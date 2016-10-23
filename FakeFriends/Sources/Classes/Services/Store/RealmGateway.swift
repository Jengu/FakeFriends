//
//  RealmGateway.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 27.09.16.
//  Copyright © 2016 Jengu. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmGateway {
  
  //MARK: - Properties
  
  var defaultRealm: Realm { get }
  var getWriteRealm: () -> Realm { get }
  
  //MARK: - Init
  
  init(realm: Realm, getWriteRealm: @escaping () -> Realm)
  
  //MARK: - Methods
  
  func save(_ object: Object, completion: (() -> Void)?)
  func save(_ objects: [Object], completion: (() -> Void)?)
  
  func delete(_ object: Object, completion: (() -> Void)?)
  func delete(_ objects: [Object], completion: (() -> Void)?)
  
}
