//
//  RealmMappedCollection.swift
//  GlossLite
//
//  Created by Daniel on 28/09/16.
//  Copyright © 2016 icecoffin. All rights reserved.
//

import Foundation
import RealmSwift

class RealmMappedCollection<Element: Object, Transformed> {
  
  typealias Transform = (Element) -> Transformed

  //MARK: - Properties
  
  private let realm: Realm
  private var results: Results<Element>
  private var notificationToken: NotificationToken?

  private var transformedCache: [Transformed] = []

  var transform: Transform
  var notificationBlock: ((RealmCollectionChange<Results<Element>>) -> Void)?

  init(realm: Realm, transform: @escaping Transform) {
    self.realm = realm
    self.transform = transform
    results = realm.objects(Element.self)
    subscribeToResultsNotifications()
  }

  private func subscribeToResultsNotifications() {
    notificationToken = results.addNotificationBlock { [unowned self] changes in
      switch changes {
      case .initial:
        break
      case .update(_, let deletions, let insertions, let modifications):
        self.handle(deletions: deletions)
        self.handle(insertions: insertions)
        self.handle(modifications: modifications)
        break
      case .error(let error):
        print(error)
        break
      }
      self.notificationBlock?(changes)
    }
  }

  private func handle(deletions: [Int]) {
    for index in deletions where index < transformedCache.count {
      transformedCache.remove(at: index)
    }
  }

  private func handle(insertions: [Int]) {
    var count = transformedCache.count
    insertions.forEach { index in
      if index < count {
        transformedCache.insert(transform(results[index]), at: index)
        count += 1
      }
    }
  }

  private func handle(modifications: [Int]) {
    let count = transformedCache.count
    modifications.forEach { index in
      if index < count {
        transformedCache[index] = transform(results[index])
      }
    }
  }

  var count: Int {
    return results.count
  }

  func item(at index: Int) -> Transformed {
    assert(index <= transformedCache.count)

    if index < transformedCache.count {
      return transformedCache[index]
    }

    let transformedValue = transform(results[index])
    transformedCache.append(transformedValue)
    return transformedValue
  }

}
