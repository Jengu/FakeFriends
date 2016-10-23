//
//  StringFormatter.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 24.09.16.
//  Copyright © 2016 Jengu. All rights reserved.
//

import Foundation

struct StringFormatter {
  
  static func formattedUsername(for friend: Friend) -> String {
    let firstName = friend.firstName ?? ""
    let lastName = friend.lastName ?? ""
    return (firstName + " " + lastName).capitalized
  }
  
}
