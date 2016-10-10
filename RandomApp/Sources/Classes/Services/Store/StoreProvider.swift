//
//  StoreProvider.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 27.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import Foundation
import RealmSwift

final class StoreProvider: Store {
  
  let defaultRealm: Realm
  let writeRealm: () -> Realm
  
  init(realm: Realm, writeRealm: @escaping () -> Realm) {
    self.defaultRealm = realm
    self.writeRealm = writeRealm
  }
  
  func save(object: Object, completion: (() -> Void)?) {
    handleInBackground(block: { realm in
      realm.add(object, update: true)
      }, completion: completion)
  }
  
  func save(objects: [Object], completion: (() -> Void)?) {
    handleInBackground(block: { realm in
      realm.add(objects, update: true)
      }, completion: completion)
  }
  
  func delete(object: Object, completion: (() -> Void)?) {
    handleInBackground(block: { realm in
      realm.delete(object)
      }, completion: completion)
  }
  
  func delete(objects: [Object], completion: (() -> Void)?) {
    handleInBackground(block: { realm in
      realm.delete(objects)
      }, completion: completion)
  }
  
  private func handleInBackground(block: @escaping (Realm) -> Void, completion: (() -> Void)?) {
    Dispatch.performInBackground { [weak self] in
      guard let `self` = self else { return }
      let backgroundRealm = self.writeRealm()
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
