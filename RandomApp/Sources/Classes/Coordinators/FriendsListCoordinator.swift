//
//  FriendsListCoordinator.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 16.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import UIKit

final class FriendsListCoordinator: BaseCoordinating {
  
  //MARK: - Properties
  
  let rootViewController: UIViewController
  private let servicesFabric = ServicesFabric()
  
  //MARK: - Init
  
  init(rootViewController: UIViewController) {
    self.rootViewController = rootViewController
  }
  
  //MARK: - Start
  
  func start() {
    showFriendsListViewController()
  }
  
  //MARK: - Show
  
  fileprivate func showFriendsListViewController() {
    let viewModel = FriendsListDefaultViewModel(apiProvider: ServicesFabric.apiProvider())
    viewModel.delegate = self
    let viewController = FriendsListViewController(viewModel: viewModel)
    
    let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh,
                                        target: viewController,
                                        action: #selector(viewController.refresh))
    viewController.navigationItem.leftBarButtonItem = refreshButton
   
    show(viewController: viewController, animated: false)
  }
  
  fileprivate func showFriendDetailsViewController(with friend: Friend) {
    let viewModel = FriendDetailsDefaultViewModel(friend: friend, imageCache: ServicesFabric.imageCache())
    let viewController = FriendDetailsViewController(viewModel: viewModel)
    show(viewController: viewController, animated: true)
  }
  
  fileprivate func show(viewController: UIViewController, animated: Bool) {
    guard let navigationController = rootViewController as? UINavigationController else {
      fatalError("Root view controller is not UINavigationController as expected")
    }
    navigationController.pushViewController(viewController, animated: animated)
  }
  
}

//MARK: - FriendsListViewModelDelegate

extension FriendsListCoordinator: FriendsListViewModelDelegate {
  
  func friendListViewModel(viewModel: FriendsListViewModel, didSelect friend: Friend) {
    showFriendDetailsViewController(with: friend)
  }
  
}
