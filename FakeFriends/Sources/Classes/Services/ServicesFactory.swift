//
//  ServicesFactory.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 21.09.16.
//  Copyright © 2016 Jengu. All rights reserved.
//

import Foundation

struct ServicesFactory {
  
  static func networkProvider() -> Network {
    return NetworkProvider()
  }
  
  static func apiProvider() -> API {
    return APIProvider(network: networkProvider())
  }
  
  static func imageCache() -> ImageCache {
    return ImageCacheProvider.shared
  }
  
  static func storeProvider() -> RealmGateway {
    return RealmGatewayProvider(realm: RealmFactory.realm()) {
      return RealmFactory.realm()
    }
  }
  
}
