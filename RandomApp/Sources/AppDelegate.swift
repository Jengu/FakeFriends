//
//  AppDelegate.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 16.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  private var appCoordinator: AppCoordinating?
  
  //MARK: - UIApplicationDelegate
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    launchApplication()
    return true
  }
  
  //MARK: - Launch
  
  private func launchApplication() {
    let window = UIWindow(frame: UIScreen.main.bounds)
    let appCoordinator = AppCoordinator(window: window)
    appCoordinator.start()
    
    self.window = window
    self.appCoordinator = appCoordinator
  }
  
}
