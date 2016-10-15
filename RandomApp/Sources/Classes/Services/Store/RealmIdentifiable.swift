//
//  RealmIdentifiable.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 12.10.16.
//  Copyright © 2016 Jengu. All rights reserved.
//

import Foundation

protocol RealmIdentifiable {
  
  var identifier: Int { get set }
  
  static func primaryKey() -> String?
  
}
