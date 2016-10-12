//
//  File.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 21.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

protocol ThreadSaveable: class {
  static func threadSaveObject<T>(object: T) -> T? where T: Object
}

extension Object: ThreadSaveable {
  static func threadSaveObject<T>(object: T) -> T? where T: Object {
    if let value = Object(value: object) as? T {
      return value
    }
    return nil
  }
}

class Friend: Object, Mappable, RealmIdentifiable {
  
  //MARK: - Properties
  
  dynamic var identifier = 0
  
  dynamic var firstName: String? = nil
  dynamic var lastName: String? = nil
  dynamic var avatarImageURLString: String? = nil
  dynamic var phoneNumber: String? = nil
  dynamic var nickname: String? = nil
  

  
  override static func primaryKey() -> String? {
    return "identifier"
  }
  
  //MARK: - Init
  
  required convenience init?(map: Map) {
    self.init()
  }
  
  //MARK: - Map
  
  func mapping(map: Map) {
    identifier <- map["id.value"]
    firstName <- map["name.first"]
    lastName <- map["name.last"]
    avatarImageURLString <- map["picture.medium"]
    phoneNumber <- map["phone"]
  }
  
}

//extension Friend {
//  
//  static var threadSaveObject: (Object) -> Object {
//    return { friend in
//      return Friend(value: friend)
//    }
//  }
//  
//}
