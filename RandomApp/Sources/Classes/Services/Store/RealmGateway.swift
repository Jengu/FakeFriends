//
//  RealmGateway.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 27.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
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
  
  typealias GetThreadSaveObject<ThreadSaveObject: Object> = (Object) -> ThreadSaveObject
  
  func save<T: Object, F>(object: T, getThreadSaveObject: GetThreadSaveObject<F>?,
            completion: (() -> Void)?) where T: RealmIdentifiable
  
  func save<T: Collection, F>(objects: T, getThreadSaveObject: GetThreadSaveObject<F>?,
            completion: (() -> Void)?) where T._Element: RealmIdentifiable
  
}
