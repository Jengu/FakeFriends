//
//  FriendDetailsViewModel.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 24.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import UIKit

protocol FriendDetailsViewModel {
  
  //MARK: - Properties
  
  var friend: Friend { get }
  
  var username: String? { get }
  var avatarImage: UIImage { get }
  var phoneNumber: String { get }
  
  var didUpdate: ((FriendDetailsViewModel) -> Void)? { get set }
  var didFail: ((Error) -> Void)? { get set }
  
  //MARK: - Init
  
  init(friend: Friend, imageCache: ImageCache)
  
}
