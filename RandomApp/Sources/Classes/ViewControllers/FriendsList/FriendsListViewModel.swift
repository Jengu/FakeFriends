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

  var willUpdate: (() -> Void)? { get set }
  var didUpdate: (() -> Void)? { get set }
  var didFail: ((Error) -> Void)? { get set }

  var sectionViewModels: [FriendsListSectionViewModel] { get }
  
  init(apiProvider: API)
  
  func numberOfSections() -> Int
  func numberOfRows(in section: Int) -> Int
  func cellViewModel(for indexPath: IndexPath) -> FriendCellViewModel
  
  func reloadData()
  
}
