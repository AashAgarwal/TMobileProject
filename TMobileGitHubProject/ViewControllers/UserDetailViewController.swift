//
//  UserDetailViewController.swift
//  TMobileGitHubProject
//
//  Created by AashAgarwal on 1/24/20.
//  Copyright © 2020 AashAgarwal. All rights reserved.
//

import UIKit
import SafariServices

final class UserDetailViewController: UIViewController {
  
  @IBOutlet weak var userImageView: UIImageView!
  @IBOutlet weak var userInformationLabel: UILabel!
  @IBOutlet weak var repositorySearchBar: UISearchBar!
  @IBOutlet weak var repositoryTableView: UITableView!
  @IBOutlet weak var userBiogrpahyLabel: UILabel!
  
  var retriever: NetworkDataRetriever!
  var user: User!
  private var repositories: [Repository] = []
  private var inputTimer: Timer?
  private let timerDelay: TimeInterval = 0.3
  private lazy var controller: RepositorySearchController = {
    return RepositorySearchController(retriever: retriever, user: user)
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    userInformationLabel.text = "UserName: \(user.name ?? user.login)\nEmail: \(user.email ?? "No Email")\nLocation: \(user.location ?? "No Location")\nJoin Date: \(user.startedAccount)\n\(user.followers) Followers\nFollowing \(user.following)"
    userBiogrpahyLabel.text = user.biography ?? "No Bio"
    repositorySearchBar.delegate = self
    repositoryTableView.dataSource = self
    repositoryTableView.delegate = self
    repositoryTableView.register(UINib(nibName: "RepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: "RepositoryTableViewCell")
    controller.getInitialRepositories { [weak self] (repos, error) in
      self?.repositories = repos ?? []
      DispatchQueue.main.async {
        self?.repositoryTableView.reloadData()
      }
    }
    guard let avatarURL = user.avatarURL else { return }
    retriever.getImage(url: avatarURL) { [weak self] (image, error) in
      DispatchQueue.main.async {
        self?.userImageView.image = image
      }
    }
  }
}

extension UserDetailViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    inputTimer?.invalidate()
    inputTimer = Timer.scheduledTimer(withTimeInterval: timerDelay, repeats: false, block: { [weak self] _ in
      self?.controller.getRepositories(with: searchText) { (repos, error) in
        self?.repositories = repos ?? []
        DispatchQueue.main.async {
          self?.repositoryTableView.reloadData()
        }
      }
    })
  }
}

extension UserDetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return repositories.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell", for: indexPath) as! RepositoryTableViewCell
    let repo = repositories[indexPath.row]
    cell.configure(with: repo)
    return cell
  }
}

extension UserDetailViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let repo = repositories[indexPath.row]
    let repoURL = repo.webURL
    let webController = SFSafariViewController(url: repoURL)
    present(webController, animated: true, completion: nil)
  }
}
