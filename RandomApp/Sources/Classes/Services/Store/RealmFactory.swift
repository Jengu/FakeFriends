//
//  RealmFactory.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 27.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmFactory {
  
  static func realm() -> Realm {
    do {
      var config = Realm.Configuration()
      config.deleteRealmIfMigrationNeeded = true
      Realm.Configuration.defaultConfiguration = config
      let realm = try Realm()
      return realm
    } catch {
      fatalError("Can't create a Realm instance")
    }
  }
  
}
