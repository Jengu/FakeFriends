//
//  File.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 21.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import Foundation
import UIKit

class FriendCellDefaultViewModel: FriendCellViewModel {
  
  //MARK: - Properties
  
  let friend: Friend
  var restrictedTo: IndexPath?
  let imageCache: ImageCache
  
  var username: String? {
    return StringFormatter.formattedUsername(for: friend)
  }
  
  var avatarImage: UIImage {
    if let avatarURL = friend.avatarImageURLString,
      let image = imageCache.cachedImage(for: avatarURL) {
      return image
    } else {
      downloadAvatarImage()
      return ImageProvider.defaultAvatarImage
    }
  }
  
  var didUpdate: ((FriendCellViewModel) -> Void)?
  
  //MARK: - Init
  
  required init(friend: Friend, imageCache: ImageCache) {
    self.friend = friend
    self.imageCache = imageCache
    didUpdate?(self)
  }
  
  //MARK: - Access
  
  func allowAccess(for object: UniqueCell) -> Bool {
    guard let uniqueIndexPath = object.uniqueIndexPath,
      let restrictedTo = restrictedTo else {
        return false
    }
    return uniqueIndexPath == restrictedTo
  }
  
  //MARK: - Download avatar image
  
  private func downloadAvatarImage() {
    guard let avatarImageURLString = friend.avatarImageURLString else {
      return
    }
    
    imageCache.downloadImage(from: avatarImageURLString, success: { [weak self] (image) in
      guard let `self` = self else {
        return
      }
      self.didUpdate?(self)
      }, failure: nil)
  }
  
}
