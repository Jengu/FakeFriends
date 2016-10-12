//
//  AppCoordinator.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 16.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import UIKit

final class AppCoordinator: AppCoordinating {
  
  //MARK: - Properties
  
  let window: UIWindow
  
  private let realmGateway = ServicesFactory.storeProvider()
  
  private var navigationController: UINavigationController?
  private var friendsListCoordinator: FriendsListCoordinator?
  
  //MARK: - Init
  
  init(window: UIWindow) {
    self.window = window
  }
  
  //MARK: - Start
  
  func start() {
    createNavigationController()
    createFriendsListCoordinator()
    window.makeKeyAndVisible()
  }
  
  //MARK: - Private methods
  
  private func createNavigationController() {
    let navigationController = UINavigationController()
    self.navigationController = navigationController
    window.rootViewController = navigationController
  }
  
  private func createFriendsListCoordinator() {
    guard let navigationController = navigationController else {
      fatalError("There is no navigation controller")
    }
    friendsListCoordinator = FriendsListCoordinator(rootViewController: navigationController,
                                                    realmGateway: realmGateway)
    friendsListCoordinator?.start()
  }
  
}
