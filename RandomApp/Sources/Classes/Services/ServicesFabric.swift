//
//  ServicesFabric.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 21.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import Foundation

protocol ServicesFabricable {
  
  static func networkProvider() -> Network
  static func apiProvider() -> API
  
}

struct ServicesFabric: ServicesFabricable {
  
  static func networkProvider() -> Network {
    return NetworkProvider()
  }
  
  static func apiProvider() -> API {
    return APIProvider(network: networkProvider())
  }
  
  static func imageCache() -> ImageCache {
    return ImageCacheProvider(network: networkProvider())
  }
  
}
