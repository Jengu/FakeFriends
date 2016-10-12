//
//  FriendsListDefaultViewModel.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 20.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import UIKit

protocol FriendsListViewModelDelegate: class {
  
  func friendListViewModel(viewModel: FriendsListViewModel, didSelect friend: Friend)
  
}

final class FriendsListDefaultViewModel: FriendsListViewModel {
  
  typealias NotificationBlock = (_ deletions: [Int], _ insertions: [Int], _ modifications: [Int]) -> Void
  
  //MARK: - Properties
  
  weak var delegate: FriendsListViewModelDelegate?
  
  let cellViewModels: RealmMappedCollection<Friend, FriendCellViewModel>
  
  private let apiProvider: API
  private let realmGateway: RealmGateway
  private let imageCache: ImageCache
  
  //MARK: - Init
  
  init(apiProvider: API, realmGateway: RealmGateway, imageCache: ImageCache) {
    self.apiProvider = apiProvider
    self.realmGateway = realmGateway
    self.imageCache = imageCache
    
    let transform = { (friend: Friend) -> FriendCellViewModel in
      return FriendCellDefaultViewModel(friend: friend, imageCache: imageCache)
    }
    
    cellViewModels = RealmMappedCollection(realm: self.realmGateway.defaultRealm, transform: transform)
  }
  
  //MARK: - Stucture helpers
  
  func numberOfSections() -> Int {
    return 1
  }
  
  func numberOfRows(in section: Int) -> Int {
    return cellViewModels.count
  }
  
  func cellViewModel(for indexPath: IndexPath) -> FriendCellViewModel {
    var cellViewModel = cellViewModels.item(at: indexPath.row)
    cellViewModel.restrictedTo = indexPath
    return cellViewModel
  }
  
  //MARK: - Reload
  
  func reloadData(completion: ((Error?) -> Void)?) {
    apiProvider.getRandomFriends(success: { [weak self] (friends) in
      guard let `self` = self else { return }
      self.realmGateway.saveObjects(friends, completion: nil)
      completion?(nil)
    }) { (error) in
      completion?(error)
    }
  }
  
  //MARK: - Notification
  
  func addNotificationBlock(block: @escaping NotificationBlock) {
    cellViewModels.notificationBlock = { results in
      switch results {
      case .update(_, let deletions, let insertions, let modifications):
        block(deletions, insertions, modifications)
        break
      default:
        break
      }
    }
  }
  
  //MARK: - Handle friend selection
  
  func selectFriend(at indexPath: IndexPath) {
    let cellViewModel = cellViewModels.item(at: indexPath.row)
    delegate?.friendListViewModel(viewModel: self, didSelect: cellViewModel.friend)
  }
  
}
