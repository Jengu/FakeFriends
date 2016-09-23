//
//  File.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 21.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import Foundation

final class FriendsListSectionDefaultViewModel: FriendsListSectionViewModel {
  
  //MARK: - Properties
  
  var cellViewModels: [FriendCellViewModel] = []
  private let friends: [Friend]

  //MARK: - Init
  
  init(friends: [Friend]) {
    self.friends = friends
    createCellViewModels()
  }
  
  //MARK: - Create view models
  
  private func createCellViewModels() {
    cellViewModels = friends.flatMap() {
      FriendCellDefaultViewModel(friend: $0, imageCache: ServicesFabric.imageCache())
    }
  }
  
}
