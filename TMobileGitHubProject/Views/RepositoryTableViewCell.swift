//
//  ReppositoryTableViewCell.swift
//  TMobileGitHubProject
//
//  Created by AashAgarwal on 1/24/20.
//  Copyright © 2020 AashAgarwal. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

  @IBOutlet weak var repositoryNameLabel: UILabel!
  @IBOutlet weak var forksLabel: UILabel!
  @IBOutlet weak var starsLabel: UILabel!
  
  func configure(with repository: Repository) {
    self.repositoryNameLabel.text = repository.name
    self.forksLabel.text = "Forks \(repository.forks)"
    self.starsLabel.text = "Stars \(repository.stars)"
  }
}
