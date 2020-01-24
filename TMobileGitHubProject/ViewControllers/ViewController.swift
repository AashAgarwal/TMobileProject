//
//  ViewController.swift
//  TMobileGitHubProject
//
//  Created by AashAgarwal on 1/24/20.
//  Copyright © 2020 AashAgarwal. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
  @IBOutlet weak var userSearchBar: UISearchBar!
  @IBOutlet weak var userTableView: UITableView!
  
  var dataRetriever: NetworkDataRetriever!
  private var userItems: [UserItem] = []
  private var inputTimer: Timer?
  private let timerDelay: TimeInterval = 0.3
  private lazy var controller: UserSearchController = {
    return UserSearchController(dataRetriever: dataRetriever)
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    userTableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
    userTableView.dataSource = self
    userTableView.delegate = self
    userSearchBar.delegate = self
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return userItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
    cell.configure(with: userItems[indexPath.row], retriever: dataRetriever)
    return cell
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let userCell = tableView.cellForRow(at: indexPath) as? UserTableViewCell, let user = userCell.user else { return }
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let detailsViewController = storyboard.instantiateViewController(identifier: "UserDetailViewController") as! UserDetailViewController
    detailsViewController.retriever = dataRetriever
    detailsViewController.user = user
    navigationController?.pushViewController(detailsViewController, animated: true)
  }
}

extension ViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    inputTimer?.invalidate()
    inputTimer = Timer.scheduledTimer(withTimeInterval: timerDelay, repeats: false, block: { [weak self] _ in
      self?.controller.getUserItems(with: searchText) { (items, error) in
        self?.userItems = items ?? []
        DispatchQueue.main.async {
          self?.userTableView.reloadData()
        }
      }
    })
  }
}
