//
//  File.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 21.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import Foundation

final class FriendsListSectionDefaultViewModel: FriendsListSectionViewModel {
  
  var cellViewModels: [FriendCellViewModel] = []
  private let friends: [Friend]

  init(friends: [Friend]) {
    self.friends = friends
    createCellViewModels()
  }
  
  private func createCellViewModels() {
    cellViewModels = friends.flatMap() {
      FriendCellDefaultViewModel(friend: $0)
    }
  }
  
}
