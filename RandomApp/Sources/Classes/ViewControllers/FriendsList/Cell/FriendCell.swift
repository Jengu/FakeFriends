//
//  FriendCell.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 20.09.16.
//  Copyright © 2016 Jengu. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell, UniqueCell {
  
  var uniqueIndexPath: IndexPath?
  private var viewModel: FriendCellViewModel?
  
  //MARK: - Properties
  
  @IBOutlet weak var avatarImageView: AvatarImageView!
  @IBOutlet weak var usernameLabel: UILabel!
  
  //MARK: - Reuse 
  
  override func prepareForReuse() {
    super.prepareForReuse()
    clear()
  }

  private func clear() {
    usernameLabel.text = ""
    avatarImageView.image = nil
  }
  
  //MARK: - Update
  
  func update(with viewModel: FriendCellViewModel) {
    self.viewModel = viewModel
    configureViewModel()
    update()
  }
  
  private func configureViewModel() {
    viewModel?.didUpdate = { [weak self] (viewModel) in
      guard let `self` = self,
        viewModel.allowAccess(for: self) else {
        return
      }
      self.update()
    }
  }
  
  private func update() {
    self.usernameLabel.text = viewModel?.username
    self.avatarImageView.image = viewModel?.avatarImage
  }
  
}
