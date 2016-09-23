//
//  FriendsListDefaultViewModel.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 20.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import UIKit

protocol FriendsListViewModelDelegate {
  
  func friendListViewModel(viewModel: FriendsListViewModel, didSelect friend: Friend)
  
}

final class FriendsListDefaultViewModel: FriendsListViewModel {
  
  //MARK: - Properties
  
  var delegate: FriendsListViewModelDelegate?
  
  var sectionViewModels: [FriendsListSectionViewModel] = []
  private var friends: [Friend] = []
  private let apiProvider: API
  
  var willUpdate: (() -> Void)?
  var didUpdate: (() -> Void)?
  var didFail: ((Error) -> Void)?
  
  //MARK: - Init
  
  init(apiProvider: API) {
    self.apiProvider = apiProvider
  }
  
  //MARK: - Stucture helpers
  
  func numberOfSections() -> Int {
    return sectionViewModels.count
  }
  
  func numberOfRows(in section: Int) -> Int {
    return sectionViewModels[section].cellViewModels.count
  }
  
  func cellViewModel(for indexPath: IndexPath) -> FriendCellViewModel {
    var cellViewModel = sectionViewModels[indexPath.section].cellViewModels[indexPath.row]
    cellViewModel.restrictedTo = indexPath
    return cellViewModel
  }
  
  //MARK: - Reload
  
  func reloadData() {
    willUpdate?()
    
    apiProvider.getRandomFriends(success: { [weak self] (friends) in
      self?.handle(new: friends)
    }) { [weak self] (error) in
      self?.handle(error: error)
    }
  }
  
  private func handle(new friends: [Friend]) {
    sectionViewModels.removeAll()
    self.friends.removeAll()
    
    self.friends.append(contentsOf: friends)
    
    let sectionViewModel = FriendsListSectionDefaultViewModel(friends: friends)
    sectionViewModels.append(sectionViewModel)
    
    didUpdate?()
  }
  
  private func handle(error: Error) {
    didFail?(error)
  }
  
  //MARK: - Handle friend selection
  
  func selectFriend(at indexPath: IndexPath) {
    delegate?.friendListViewModel(viewModel: self, didSelect: friends[indexPath.row])
  }
  
}
