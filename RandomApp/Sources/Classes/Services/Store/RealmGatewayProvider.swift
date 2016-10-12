//
//  RealmGatewayProvider.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 27.09.16.
//  Copyright © 2016 Jengu. All rights reserved.
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
  
  func save<T: Object>(_ object: T, completion: (() -> Void)?) where T: ThreadSaveable {
    handleInBackground(block: { [weak self] realm in
      guard let `self` = self else { return }
      self.save(in: realm, object: object)
      }, completion: completion)
  }
  
  func save<T: Object>(_ objects: [T], completion: (() -> Void)?) where T: ThreadSaveable {
    handleInBackground(block: { [weak self] realm in
      guard let `self` = self else { return }
      for object in objects {
        self.save(in: realm, object: object)
      }
      }, completion: completion)
  }
  
  //MARK: - Private
  
  private func save<T: Object>(in realm: Realm, object: T) where T: ThreadSaveable {
    let threadSaveObject = object.threadSaveObject()
    realm.add(threadSaveObject, update: true)
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
