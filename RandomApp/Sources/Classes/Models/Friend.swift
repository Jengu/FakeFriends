//
//  File.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 21.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import Foundation
import ObjectMapper

class Friend: Mappable {
  
  var firstName: String?
  var lastName: String?
  var avatarImageURLString: String?
  
  required init?(map: Map) {
  }
  
  func mapping(map: Map) {
    firstName <- map["name.first"]
    lastName <- map["name.last"]
    avatarImageURLString <- map["picture.thumbnail"]
  }
  
}