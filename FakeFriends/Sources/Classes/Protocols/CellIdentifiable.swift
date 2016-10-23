//
//  CellIdentifiable.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 20.09.16.
//  Copyright © 2016 Jengu. All rights reserved.
//

import UIKit

protocol CellIdentifiable {
  
  static var cellReuseIdentifier: String { get }
  
}
