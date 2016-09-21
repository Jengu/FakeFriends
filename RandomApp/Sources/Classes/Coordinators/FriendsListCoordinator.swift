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
  
  //MARK: - Private methods
  
  private func showFriendsListViewController() {
    let viewModel = FriendsListDefaultViewModel(apiProvider: ServicesFabric.apiProvider())
    let viewController = FriendsListViewController(viewModel: viewModel)
    guard let navigationController = rootViewController as? UINavigationController else {
      fatalError("Root view controller is not UINavigationController as expected")
    }
    navigationController.pushViewController(viewController, animated: false)
  }
  
}
