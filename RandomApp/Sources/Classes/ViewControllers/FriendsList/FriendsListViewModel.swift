//
//  FriendsListViewModel.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 16.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import Foundation
import UIKit

protocol FriendsListViewModel {
  
  //MARK: - Properties

  var sectionViewModels: [FriendsListSectionViewModel] { get }

  var willUpdate: (() -> Void)? { get set }
  var didUpdate: (() -> Void)? { get set }
  var didFail: ((Error) -> Void)? { get set }

  //MARK: - Init
  
  init(apiProvider: API, store: Store)
  
  //MARK: - Methods
  
  func numberOfSections() -> Int
  func numberOfRows(in section: Int) -> Int
  func cellViewModel(for indexPath: IndexPath) -> FriendCellViewModel
  
  func reloadData()
  
  func selectFriend(at indexPath: IndexPath)
  
}
