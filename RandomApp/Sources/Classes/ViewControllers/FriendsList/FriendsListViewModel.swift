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

  var sectionViewModels: [FriendsListSectionViewModel] { get }
  
  func numberOfSections() -> Int
  func numberOfRows(in section: Int) -> Int
  
  func reloadData()
  
}
