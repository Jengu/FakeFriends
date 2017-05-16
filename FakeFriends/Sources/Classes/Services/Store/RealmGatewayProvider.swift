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
    
  //MARK: - Properties
  
  let defaultRealm: Realm
  let getWriteRealm: () -> Realm
  
  //MARK: - Init
  
  init(realm: Realm, getWriteRealm: @escaping () -> Realm) {
    self.defaultRealm = realm
    self.getWriteRealm = getWriteRealm
  }
  
  //MARK: - Save
  
  func save(_ object: Object, completion: (() -> Void)?) {
    handleInBackground(block: { realm in
      realm.add(object, update: true)
      }, completion: completion)
  }
  
  func save(_ objects: [Object], completion: (() -> Void)?) {
    handleInBackground(block: { realm in
      realm.add(objects)
      }, completion: completion)
  }
  
  //MARK: - Delete
  
  func delete(_ object: Object, completion: (() -> Void)?) {
    let identifier = self.identifier(of: object)
    
    handleInBackground(block: { realm in
      if let deletingObject = realm.object(ofType: type(of: object), forPrimaryKey: identifier) {
        realm.delete(deletingObject)
      }
      }, completion: completion)
  }
  
  func delete(_ objects: [Object], completion: (() -> Void)?) {
    var deletingObjectIdentifiers: [Int] = []
    objects.forEach({ (object) in
      deletingObjectIdentifiers.append(self.identifier(of: object))
    })

    handleInBackground(block: { realm in
      guard let firstObject = objects.first else { return }
      let predicate = NSPredicate(format: "identifier IN %@", deletingObjectIdentifiers)
      let deletingObjects = realm.objects(type(of: firstObject)).filter(predicate)
      realm.delete(deletingObjects)
      }, completion: completion)
  }
  
  private func identifier(of object: Object) -> Int {
    guard let identifiableObject = object as? RealmIdentifiable else {
      fatalError("Object should be RealmIdentifiable")
    }
    return identifiableObject.identifier
  }

  //MARK: - Private
  
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
