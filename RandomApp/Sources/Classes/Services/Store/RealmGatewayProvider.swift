//
//  RealmGatewayProvider.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 27.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmGatewayProvider: RealmGateway {
  
  typealias GetThreadSaveObject<ThreadSaveObject: Object> = (Object) -> ThreadSaveObject
  
  //MARK: - Properties
  
  let defaultRealm: Realm
  let getWriteRealm: () -> Realm
  
  //MARK: - Init
  
  init(realm: Realm, getWriteRealm: @escaping () -> Realm) {
    self.defaultRealm = realm
    self.getWriteRealm = getWriteRealm
  }
  
  //MARK: - Save
  
  func saveObject<T: Object>(_ object: T, completion: (() -> Void)?) {
    handleInBackground(block: { [weak self] realm in
      guard let `self` = self else { return }
      self.save(in: realm, object: object)
      }, completion: completion)
  }
  
  func saveObjects<T: Object>(_ objects: [T], completion: (() -> Void)?) {
    handleInBackground(block: { [weak self] realm in
      guard let `self` = self else { return }
      for object in objects {
        self.save(in: realm, object: object)
      }
      }, completion: completion)
  }
  
  //MARK: - Private
  
  private func save<T: Object>(in realm: Realm, object: T) {
    
    guard let threadSaveableObject = object as? ThreadSaveable else {
      fatalError()
    }
    
    guard let newObject = threadSaveableObject.threadSaveObject(object: object) as? Object else {
      fatalError()
    }
    
    realm.add(newObject, update: true)

//    if let newThreadSaveObject = getThreadSaveObject(object) as? Object {
//      realm.add(newThreadSaveObject, update: true)
//    }
    
    //    guard let identifiable = object as? RealmIdentifiable else { return }
    //    let identifier = identifiable.identifier
    //
    //
    //    if let threadSaveObject = realm.object(ofType: T.self, forPrimaryKey: identifier) {
    //      realm.add(threadSaveObject, update: true)
    //    } else {
    //      if let newThreadSaveObject = getThreadSaveObject(object) as? Object {
    //        realm.add(newThreadSaveObject, update: true)
    //      }
    //    }
  }
  
  private func handleInBackground(block: @escaping (Realm) -> Void, completion: (() -> Void)?) {
    Dispatch.performInBackground { [weak self] in
      guard let `self` = self else { return }
      let backgroundRealm = self.getWriteRealm()
      do {
        try backgroundRealm.write {
          block(backgroundRealm)
        }
      } catch {
        fatalError("Can't write to a Realm instance")
      }
      Dispatch.performInMainQueue {
        self.defaultRealm.refresh()
        completion?()
      }
    }
  }
  
}
