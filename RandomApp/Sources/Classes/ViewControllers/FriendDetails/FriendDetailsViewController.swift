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
  
  fileprivate var viewModel: FriendDetailsViewModel
  
  lazy private var avatarImageView: AvatarImageView = AvatarImageView()
  lazy private var usernameLabel = UILabel()
  lazy private var phoneLabel = UILabel()
  lazy private var nicknameTextField = UITextField()
  
  private var tapGR: UITapGestureRecognizer?
  
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
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    viewModel.save(new: nicknameTextField.text)
  }
  
  //MARK: - Configure
  
  private func configureView() {
    view.backgroundColor = UIColor.white
    addUIElements()
    addTapGestureRecognizer()
    configureViewModel()
    viewModelDidUpdate()
  }
  
  //MARK: UI
  
  private func addUIElements() {
    addAvatarImageView()
    addUsernameLabel()
    addPhoneLabel()
    addNicknameTextField()
  }
  
  private func addAvatarImageView() {
    view.addSubview(avatarImageView)
    avatarImageView.snp.makeConstraints { (make) in
      make.top.equalTo(self.view).offset(16 + 44 + 20)
      make.width.height.equalTo(84)
      make.centerX.equalTo(self.view)
    }
  }
  
  private func addUsernameLabel() {
    view.addSubview(usernameLabel)
    usernameLabel.snp.makeConstraints { (make) in
      make.top.equalTo(self.avatarImageView.snp.bottom).offset(8)
      make.centerX.equalTo(self.view)
    }
  }
  
  private func addPhoneLabel() {
    view.addSubview(phoneLabel)
    phoneLabel.snp.makeConstraints { (make) in
      make.top.equalTo(self.usernameLabel.snp.bottom).offset(8)
      make.centerX.equalTo(self.view)
    }
  }
  
  private func addNicknameTextField() {
    view.addSubview(nicknameTextField)
    nicknameTextField.snp.makeConstraints { (make) in
      make.top.equalTo(self.phoneLabel.snp.bottom).offset(16)
      make.leading.trailing.equalTo(self.view).inset(8)
      make.height.equalTo(32)
    }
    nicknameTextField.placeholder = "Nickname"
    nicknameTextField.layer.borderColor = UIColor.black.cgColor
    nicknameTextField.layer.borderWidth = 1
    nicknameTextField.layer.cornerRadius = 5
    nicknameTextField.textAlignment = NSTextAlignment.center
  }
  
  //MARK: Tap GR
  
  private func addTapGestureRecognizer() {
    let tapGR = UITapGestureRecognizer(target: self,
                                       action: #selector(handleTap(tapGR:)))
    view.addGestureRecognizer(tapGR)
    
    self.tapGR = tapGR
  }
  
  //MARK: ViewModel
  
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
    nicknameTextField.text = viewModel.nickname
  }
  
  private func viewModelDidFail(error: Error) {
    showAlert(with: error)
  }
  
  //MARK: - Handle tap GR
  
  @objc private func handleTap(tapGR: UITapGestureRecognizer) {
    view.endEditing(true)
  }
  
}
