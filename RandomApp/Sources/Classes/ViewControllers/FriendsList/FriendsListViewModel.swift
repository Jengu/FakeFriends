//
//  FriendsListViewModel.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 16.09.16.
//  Copyright © 2016 Jengu. All rights reserved.
//

import Foundation
import UIKit

protocol FriendsListViewModel {
  
  typealias NotificationBlock = (_ deletions: [Int], _ insertions: [Int], _ modifications: [Int]) -> Void
  
  //MARK: - Properties
  
  var cellViewModels: RealmMappedCollection<Friend, FriendCellViewModel> { get }

  //MARK: - Init
  
  init(apiProvider: API, realmGateway: RealmGateway, imageCache: ImageCache)
  
  //MARK: - Methods
  
  func numberOfSections() -> Int
  func numberOfRows(in section: Int) -> Int
  func cellViewModel(for indexPath: IndexPath) -> FriendCellViewModel
  
  func reloadData(completion: ((Error?) -> Void)?)
  
  func selectFriend(at indexPath: IndexPath)
  
  func addNotificationBlock(block: @escaping NotificationBlock)
  
}
