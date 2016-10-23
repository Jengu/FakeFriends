//
//  RequestFactoryProvider.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 21.09.16.
//  Copyright © 2016 Jengu. All rights reserved.
//

import Foundation

struct RequestFactory {
  
  //MARK: - Private helpers
  
  private struct URLFactory {
    private static let baseURL = "http://api.randomuser.me"
    private static var resultsPart = "?results="
    
    static func randomFriendsURL(count: Int) -> String {
      return "\(baseURL)/\(resultsPart)\(count)"
    }
  }

  private struct DefaultRequestsCount {
    static let randomFriendsCount = 20
  }
  
  //MARK: - Requests
  
  static func randomFriendsRequest() -> NetworkRequest {
    return NetworkRequest(method: .get,
                          url: URLFactory.randomFriendsURL(count: DefaultRequestsCount.randomFriendsCount))
  }
  
  static func imageRequest(from url: String) -> NetworkRequest {
    return NetworkRequest(method: .get, url: url)
  }
  
}
