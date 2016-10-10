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
  private let servicesFactory = ServicesFactory()
  private let store: Store
  
  //MARK: - Init
  
  init(rootViewController: UIViewController, store: Store) {
    self.rootViewController = rootViewController
    self.store = store
  }
  
  //MARK: - Start
  
  func start() {
    showFriendsListViewController()
  }
  
  //MARK: - Show
  
  fileprivate func showFriendsListViewController() {
    let viewModel = FriendsListDefaultViewModel(apiProvider: ServicesFactory.apiProvider(),
                                                store: store)
    viewModel.delegate = self
    let viewController = FriendsListViewController(viewModel: viewModel)
    
    let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh,
                                        target: viewController,
                                        action: #selector(viewController.refresh))
    viewController.navigationItem.leftBarButtonItem = refreshButton
    viewController.navigationItem.title = "FRIENDS"
    
    show(viewController: viewController, animated: false)
  }
  
  fileprivate func showFriendDetailsViewController(with friend: Friend) {
    let viewModel = FriendDetailsDefaultViewModel(friend: friend, imageCache: ServicesFactory.imageCache(),
                                                  store: store)
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
