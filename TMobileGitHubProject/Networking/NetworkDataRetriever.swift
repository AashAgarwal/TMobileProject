//
//  NetworkDataRetriever.swift
//  TMobileGitHubProject
//
//  Created by AashAgarwal on 1/24/20.
//  Copyright © 2020 AashAgarwal. All rights reserved.
//

import UIKit

final class NetworkDataRetriever {
  
  private let session: DataSession
  
  init(session: DataSession = URLSession.shared) {
    self.session = session
  }
  
  func getDecodableObject<T: Decodable>(_ decodableType: T.Type, url: String, completion: @escaping (T?, Error?) -> Void) {
    let authHeaders = ["Authorization": "token 48fc9315d12a8010b82db7ed763ae82cfd7c35c5"]
    self.session.getData(urlString: url, headers: authHeaders) { (data, error) in
      guard let data = data else {
        completion(nil, NetworkingErrors.noData)
        return
      }
      do {
        let decodedObject = try JSONDecoder().decode(T.self, from: data)
        completion(decodedObject, nil)
      } catch {
        completion(nil, error)
      }
    }
  }
  
  func getImage(url: String, completion: @escaping (UIImage?, Error?) -> Void) {
    self.session.getData(urlString: url, headers: [:]) { (data, error) in
      guard error == nil else {
        completion(nil, error)
        return
      }
      guard let data = data else {
        completion(nil, NetworkingErrors.noData)
        return
      }
      guard let image = UIImage(data: data) else {
        completion(nil, NetworkingErrors.badData)
        return
      }
      completion(image, nil)
    }
  }
}
