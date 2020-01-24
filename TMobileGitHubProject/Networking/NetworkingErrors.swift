//
//  NetworkingErrors.swift
//  TMobileGitHubProject
//
//  Created by AashAgarwal on 1/24/20.
//  Copyright © 2020 AashAgarwal. All rights reserved.
//

import Foundation

enum NetworkingErrors: Error {
  case invalidURL
  case forbidden
  case noData
  case badData
}
