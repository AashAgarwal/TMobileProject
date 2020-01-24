//
//  RepositoryController.swift
//  TMobileGitHubProject
//
//  Created by AashAgarwal on 1/24/20.
//  Copyright © 2020 AashAgarwal. All rights reserved.
//

import Foundation

final class RepositorySearchController {
  private let retriever: NetworkDataRetriever
  private let user: User
  
  init(retriever: NetworkDataRetriever, user: User) {
    self.retriever = retriever
    self.user = user
  }
  
  func getInitialRepositories(completion: @escaping ([Repository]?, Error?) -> Void) {
    retriever.getDecodableObject([Repository].self, url: user.repositoriesURL, completion: completion)
  }
  
  func getRepositories(with searchTerm: String, completion: @escaping ([Repository]?, Error?) -> Void) {
    let searchURL = searchRepoURL(searchTerm)
    retriever.getDecodableObject(RepositoryItems.self, url: searchURL) { (items, error) in
      completion(items?.items, error)
    }
  }
  
  private func searchRepoURL(_ search: String) -> String {
    return "https://api.github.com/search/repositories?q=\(search)+user:\(user.login)"
  }
}
