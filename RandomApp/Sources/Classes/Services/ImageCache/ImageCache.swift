//
//  ImageCache.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 22.09.16.
//  Copyright © 2016 Jengu. All rights reserved.
//

import Foundation
import UIKit

enum ImageCacheError: Error, CustomStringConvertible {
  case invalidResponse
  
  var description: String {
    switch self {
    case .invalidResponse:
      return "Received an invalid response"
    }
  }
}

protocol ImageCache {
  
  init(network: Network)
  
  func downloadImage(from url: String,
                     success: ((UIImage) -> Void)?,
                     failure: ((Error) -> Void)?)
  
  func cachedImage(for url: String) -> UIImage?
  
}
