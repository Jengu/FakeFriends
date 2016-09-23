//
//  ImageCacheProvider.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 22.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import Foundation
import UIKit

class ImageCacheProvider: ImageCache {
  
  //MARK: - Properties
  
  private let network: Network
  private var cache: [String : UIImage] = [:]
  
  //MARK: - Init
  
  required init(network: Network) {
    self.network = network
  }
  
  //MARK: - Download and cache
  
  func downloadImage(from url: String,
                     success: ((UIImage) -> Void)?,
                     failure: ((Error) -> Void)?) {
    if let image = cachedImage(for: url) {
      success?(image)
      return
    }
    
    let request = RequestFabric.imageRequest(from: url)
    
    network.make(request: request, success: { [weak self] (data: Data) in
      
      guard let image = UIImage(data: data) else {
        failure?(ImageCacheError.invalidResponse)
        return
      }
      
      self?.cache(image: image, for: url)
      success?(image)
      
      }, failure: failure)
  }
  
  func cachedImage(for url: String) -> UIImage? {
    return cache[url]
  }
  
  private func cache(image: UIImage, for url: String) {
    cache[url] = image
  }
  
}
