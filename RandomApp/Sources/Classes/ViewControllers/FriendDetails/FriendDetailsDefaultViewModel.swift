//
//  FriendDetailsDefaultViewModel.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 24.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import UIKit

final class FriendDetailsDefaultViewModel: FriendDetailsViewModel {
  
  //MARK: - Properties
  
  private let imageCache: ImageCache
  private let realmGateway: RealmGateway
  
  var friend: Friend
  
  var username: String {
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
  
  var phoneNumber: String {
    return friend.phoneNumber ?? ""
  }
  
  var nickname: String {
    return friend.nickname ?? ""
  }
  
  var didUpdate: ((FriendDetailsViewModel) -> Void)?
  var didFail: ((Error) -> Void)?
  
  //MARK: - Init
  
  init(friend: Friend, imageCache: ImageCache, realmGateway: RealmGateway) {
    self.friend = Friend(value: friend)
    self.imageCache = imageCache
    self.realmGateway = realmGateway
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
    }) { [weak self] (error) in
      self?.didFail?(error)
    }
  }
  
  //MARK: - Save
  
  func save(new nickname: String?) {
    friend.nickname = nickname
    self.realmGateway.save(object: friend,
                           getThreadSaveObject: Friend.threadSaveObject,
                           completion: nil)
  }
  
}
