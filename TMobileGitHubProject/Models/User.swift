//
//  User.swift
//  TMobileGitHubProject
//
//  Created by AashAgarwal on 1/24/20.
//  Copyright © 2020 AashAgarwal. All rights reserved.
//

import Foundation

struct User: Decodable {
  let login: String
  let name: String?
  let avatarURL: String?
  let location: String?
  let email: String?
  let biography: String?
  let repositoriesURL: String
  let followers: Int
  let following: Int
  let startedAccount: String
  let publicRepos: Int
  
  enum CodingKeys: String, CodingKey {
    case login
    case name
    case avatarURL = "avatar_url"
    case location
    case email
    case biography = "bio"
    case repositoriesURL = "repos_url"
    case followers
    case following
    case startedAccount = "created_at"
    case publicRepos = "public_repos"
  }
}
