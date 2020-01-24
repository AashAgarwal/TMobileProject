//
//  Repository.swift
//  TMobileGitHubProject
//
//  Created by AashAgarwal on 1/24/20.
//  Copyright © 2020 AashAgarwal. All rights reserved.
//

import Foundation

struct Repository: Decodable {
  let name: String
  let stars: Int
  let forks: Int
  let webURL: URL
  
  enum CodingKeys: String, CodingKey {
    case name
    case stars = "stargazers_count"
    case forks
    case webURL = "html_url"
  }
}
