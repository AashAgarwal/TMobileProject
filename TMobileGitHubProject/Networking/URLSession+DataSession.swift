//
//  URLSession+DataSession.swift
//  TMobileGitHubProject
//
//  Created by AashAgarwal on 1/24/20.
//  Copyright © 2020 AashAgarwal. All rights reserved.
//

import Foundation

extension URLSession: DataSession {
  func getData(urlString: String, headers: [String: String], completion: @escaping (Data?, Error?) -> Void) {
    guard let url = URL(string: urlString) else {
      completion(nil, NetworkingErrors.invalidURL)
      return
    }
    var request = URLRequest(url: url)
    if !headers.isEmpty {
      request.allHTTPHeaderFields = headers
    }
    self.dataTask(with: request) { (data, response, error) in
      let forbiddenStatus = 403
      guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == forbiddenStatus else {
        completion(data, error)
        return
      }
      completion(nil, NetworkingErrors.forbidden)
    }.resume()
  }
}
