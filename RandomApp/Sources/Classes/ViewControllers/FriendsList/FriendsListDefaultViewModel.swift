//
//  FriendsListDefaultViewModel.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 20.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import UIKit

class FriendsListDefaultViewModel: FriendsListViewModel {
  
  //MARK: - Properties
  
  var sectionViewModels: [FriendsListSectionViewModel] = []
  
  //MARK: - Stucture helpers
  
  func numberOfSections() -> Int {
    return sectionViewModels.count
  }
  
  func numberOfRows(in section: Int) -> Int {
    return sectionViewModels[section].cellViewModels.count
  }
  
  //MARK: - Reload
  
  func reloadData() {
    
  }
  
}
