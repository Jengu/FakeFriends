//
//  FriendCellViewModel.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 20.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import Foundation
import UIKit

protocol FriendCellViewModel {
  
  //MARK: - Properties
  
  var friend: Friend { get }
  var username: String? { get }
  var avatarImage: UIImage { get }

  var restrictedTo: IndexPath? { get set }
  
  var didUpdate: ((FriendCellViewModel) -> Void)? { get set }
  
  //MARK: - Init
  
  init(friend: Friend, imageCache: ImageCache)
  
  //MARK: - Methods
  
  func allowAccess(for uniqueCell: UniqueCell) -> Bool
  
}
