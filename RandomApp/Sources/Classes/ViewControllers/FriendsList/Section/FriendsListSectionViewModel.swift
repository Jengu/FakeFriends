//
//  File.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 20.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import Foundation

protocol FriendsListSectionViewModel {
 
  var cellViewModels: [FriendCellViewModel] { get }
  
  init(friends: [Friend])
  
}
