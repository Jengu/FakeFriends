//
//  CoordinatorsProtocols.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 16.09.16.
//  Copyright © 2016 Jengu. All rights reserved.
//

import UIKit

protocol InitialCoordinating {
  
  func start()
  
}

protocol BaseCoordinating: InitialCoordinating {
  
  var rootViewController: UIViewController { get }
  
  init(rootViewController: UIViewController, realmGateway: RealmGateway)
  
}

protocol AppCoordinating: InitialCoordinating {
  
  var window: UIWindow { get }
  
  init(window: UIWindow)
  
}
