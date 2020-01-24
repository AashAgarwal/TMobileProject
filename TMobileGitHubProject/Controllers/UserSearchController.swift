//
//  UserSearchController.swift
//  TMobileGitHubProject
//
//  Created by AashAgarwal on 1/24/20.
//  Copyright © 2020 AashAgarwal. All rights reserved.
//


final class UserSearchController {
  
  private let dataRetriever: NetworkDataRetriever
  
  init(dataRetriever: NetworkDataRetriever) {
    self.dataRetriever = dataRetriever
  }
  
  func getUserItems(with searchTerm: String, completion: @escaping ([UserItem]?, Error?) -> Void) {
    let searchURL = getUserSearchURL(searchTerm)
    dataRetriever.getDecodableObject(UserItems.self, url: searchURL) { (userItems, error) in
      guard error == nil else {
        completion(nil, error)
        return
      }
      let items = userItems?.items
      completion(items, nil)
    }
  }
  
  private func getUserSearchURL(_ searchTerm: String) -> String {
    return "https://api.github.com/search/users?q=\(searchTerm)"
  }
}
