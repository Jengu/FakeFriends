//
//  FriendCell.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 20.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell, ViewModelUpdatable {
  
  typealias ViewModel = FriendCellViewModel
  
  //MARK: - Properties
  
  @IBOutlet weak var avatarImageView: AvatarImageView!
  @IBOutlet weak var usernameLabel: UILabel!
  
  //MARK: - Update
  
  func update(with viewModel: FriendCellViewModel) {
    usernameLabel.text = viewModel.username
  }
  
}
