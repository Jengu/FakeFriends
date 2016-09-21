//
//  RequestFabricProvider.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 21.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import Foundation

struct URLFabric {
  
  private static let baseURL = "http://api.randomuser.me"
  private static var resultsPart = "?results="
  
  static func randomFriendsURL(count: Int) -> String {
    return "\(baseURL)/\(resultsPart)\(count)"
  }
  
}

struct DefaultRequestsCount {
  
  static let randomFriendsCount = 20
  
}

struct RequestFabric {
  
  static func randomFriendsRequest() -> NetworkRequest {
    return NetworkRequest(method: .get,
                          url: URLFabric.randomFriendsURL(count: DefaultRequestsCount.randomFriendsCount))
  }
  
}
