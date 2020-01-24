//
//  UserTableViewCell.swift
//  TMobileGitHubProject
//
//  Created by AashAgarwal on 1/24/20.
//  Copyright © 2020 AashAgarwal. All rights reserved.
//

import UIKit

final class UserTableViewCell: UITableViewCell {

  @IBOutlet weak var userImageView: UIImageView!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var repositoryCountLabel: UILabel!
  
  var user: User?
  
  override func prepareForReuse() {
    super.prepareForReuse()
    userImageView.image = nil
    usernameLabel.text = "UserName"
    repositoryCountLabel.text = "Repos Count"
  }
  
  func configure(with item: UserItem, retriever: NetworkDataRetriever) {
    let controller = UserController(retriever: retriever, item: item)
    controller.getUser { [weak self] (user, error) in
      self?.user = user
      DispatchQueue.main.async {
        guard error == nil else { return }
        self?.usernameLabel.text = user?.name
        self?.repositoryCountLabel.text = "Repos: \(user?.publicRepos ?? 0)"
      }
      guard let imageURL = user?.avatarURL else { return }
      retriever.getImage(url: imageURL) { (image, _) in
        DispatchQueue.main.async {
          self?.userImageView.image = image
        }
      }
    }
  }
}
