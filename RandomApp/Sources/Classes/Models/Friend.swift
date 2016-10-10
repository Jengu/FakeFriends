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

class Friend: Object, ModelIdentifiable, Mappable {
  
  //MARK: - Properties
  
  dynamic var id = 0
  
  dynamic var firstName: String? = nil
  dynamic var lastName: String? = nil
  dynamic var avatarImageURLString: String? = nil
  dynamic var phoneNumber: String? = nil
  dynamic var nickname: String? = nil
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  //MARK: - Init
  
  required convenience init?(map: Map) {
    self.init()
  }
  
  //MARK: - Map
  
  func mapping(map: Map) {
    id <- map["id.value"]
    firstName <- map["name.first"]
    lastName <- map["name.last"]
    avatarImageURLString <- map["picture.medium"]
    phoneNumber <- map["phone"]
  }
  
}
