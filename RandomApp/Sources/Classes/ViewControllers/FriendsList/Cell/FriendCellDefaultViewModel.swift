//
//  File.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 21.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import Foundation

class FriendCellDefaultViewModel: FriendCellViewModel {
  
  private let friend: Friend
  
  var username: String? {
    let firstName = friend.firstName ?? ""
    let lastName = friend.lastName ?? ""
    return (firstName + " " + lastName).capitalized
  }
  
  var avatarImageURLString: String? {
    return friend.avatarImageURLString
  }
  
  required init(friend: Friend) {
    self.friend = friend
  }
  
}
