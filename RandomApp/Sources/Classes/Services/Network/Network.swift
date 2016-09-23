//
//  Network.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 21.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
  case unknown
  case invalidResponse
  
  var description: String {
    switch self {
    case .unknown:
      return "An unknown error"
    case .invalidResponse:
      return "An invalid response error"
    }
  }
}

protocol Network {
    
  func make(request: NetworkRequest,
            success: (([String : AnyObject]) -> Void)?,
            failure: ((Error) -> Void)?)
  
  func make(request: NetworkRequest,
            success: ((Data) -> Void)?,
            failure: ((Error) -> Void)?)
  
}
