//
//  API.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 21.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
  case invalidResponse
  case notFound
  
  var description: String {
    switch self {
    case .invalidResponse: return "Received an invalid response"
    case .notFound: return "Requested item was not found"
    }
  }
}

protocol API {
  
  var network: Network { get }
  
  init(network: Network)
  
  func getRandomFriends(success: @escaping ([Friend]) -> Void,
                        failure: @escaping (Error) -> Void)
  
}
