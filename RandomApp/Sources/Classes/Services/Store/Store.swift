//
//  Store.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 27.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import Foundation
import RealmSwift

protocol Store {
  
  //MARK: - Properties
  
  var defaultRealm: Realm { get }
  var writeRealm: () -> Realm { get }
  
  //MARK: - Init
  
  init(realm: Realm, writeRealm: @escaping () -> Realm)
 
  //MARK: - Methods
  
  func save(object: Object, completion: (() -> Void)?)
  func save(objects: [Object], completion: (() -> Void)?)
  
  func delete(object: Object, completion: (() -> Void)?)
  func delete(objects: [Object], completion: (() -> Void)?)
  
}
