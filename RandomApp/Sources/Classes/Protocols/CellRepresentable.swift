//
//  CellRepresentable.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 20.09.16.
//  Copyright © 2016 Jengu. All rights reserved.
//

import UIKit

protocol CellRepresentable {
  
  static func registerCell(for tableView: UITableView)
  static func dequeueCell(for tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell
  
}
