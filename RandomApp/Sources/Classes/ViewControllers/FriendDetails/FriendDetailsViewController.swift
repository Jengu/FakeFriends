//
//  FriendDetailsViewController.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 24.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import UIKit

class FriendDetailsViewController: UIViewController {
  
  //MARK: - Properties
  
  private var viewModel: FriendDetailsViewModel
  
  lazy private var avatarImageView: AvatarImageView = AvatarImageView()
  lazy private var usernameLabel = UILabel()
  lazy private var phoneLabel = UILabel()
  
  //MARK: - Init
  
  init(viewModel: FriendDetailsViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
    configureViewModel()
    viewModelDidUpdate()
  }
  
  //MARK: - Configure
  
  private func configureView() {
    view.backgroundColor = UIColor.white
    
    view.addSubview(avatarImageView)
    avatarImageView.snp.makeConstraints { (make) in
      make.top.equalTo(self.view).offset(16)
      make.width.height.equalTo(44)
      make.centerX.equalTo(self.view)
    }
  }
  
  private func configureViewModel() {
    viewModel.didUpdate = { [weak self] (viewModel) in
      self?.viewModelDidUpdate()
    }
    
    viewModel.didFail = { [weak self] (error) in
    self?.viewModelDidFail(error: error)
    }
  }
  
  private func viewModelDidUpdate() {
    avatarImageView.image = viewModel.avatarImage
    usernameLabel.text = viewModel.username
    phoneLabel.text = viewModel.phoneNumber
  }
  
  private func viewModelDidFail(error: Error) {
    showAlert(with: error)
  }
  
}
