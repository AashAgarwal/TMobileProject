//
//  UserItem.swift
//  TMobileGitHubProject
//
//  Created by AashAgarwal on 1/24/20.
//  Copyright © 2020 AashAgarwal. All rights reserved.
//

import Foundation

struct UserItem: Decodable {
  let userURL: String
  
  enum CodingKeys: String, CodingKey {
    case userURL = "url"
  }
}
