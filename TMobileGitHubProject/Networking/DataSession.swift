//
//  DataSession.swift
//  TMobileGitHubProject
//
//  Created by AashAgarwal on 1/24/20.
//  Copyright © 2020 AashAgarwal. All rights reserved.
//

import Foundation

protocol DataSession {
  func getData(urlString: String, headers: [String: String], completion: @escaping (Data?, Error?) -> Void)
}
