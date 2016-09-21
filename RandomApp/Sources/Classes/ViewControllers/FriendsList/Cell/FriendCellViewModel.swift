//
//  FriendCellViewModel.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 20.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import Foundation

protocol FriendCellViewModel {
  
  var username: String? { get }
  var avatarImageURLString: String? { get }
  
  init(friend: Friend)
  
}
