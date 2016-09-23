//
//  NetworkRequest.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 21.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import Foundation

enum NetworkRequestError: Error, CustomStringConvertible {
  case invalidURL(String)
  
  var description: String {
    switch self {
    case .invalidURL(let url):
      return "Invalid url '\(url)'"
    }
  }
}

struct NetworkRequest {

  enum Method: String {
    case get = "GET"
    case put = "PUT"
    case patch = "PATCH"
    case post = "POST"
    case delete = "DELETE"
  }
  
  let method: Method
  let url: String
  
  func buildURLRequest() throws -> URLRequest {
    guard let url = URL(string: self.url) else {
      throw NetworkRequestError.invalidURL(self.url)
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = self.method.rawValue
    
    return request
  }
}
