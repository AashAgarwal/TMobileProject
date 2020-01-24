//
//  UserController.swift
//  TMobileGitHubProject
//
//  Created by AashAgarwal on 1/24/20.
//  Copyright © 2020 AashAgarwal. All rights reserved.
//

import Foundation

final class UserController {
  
  private let dataRetriever: NetworkDataRetriever!
  private let item: UserItem!
  
  init(retriever: NetworkDataRetriever, item: UserItem) {
    dataRetriever = retriever
    self.item = item
  }
  
  func getUser(completion: @escaping (User?, Error?) -> Void) {
    dataRetriever.getDecodableObject(User.self, url: item.userURL, completion: completion)
  }
}
