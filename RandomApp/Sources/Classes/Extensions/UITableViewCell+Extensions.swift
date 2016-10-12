//
//  File.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 20.09.16.
//  Copyright © 2016 Jengu. All rights reserved.
//

import UIKit

extension UITableViewCell: CellRepresentable {
  
  static func registerCell(for tableView: UITableView) {
    let cellNib = UINib(nibName: String(describing: self), bundle: nil)
    tableView.register(cellNib, forCellReuseIdentifier: UITableViewCell.cellReuseIdentifier)
  }
  
  static func dequeueCell(for tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.cellReuseIdentifier,
                                             for: indexPath)
    return cell
  }
  
}

extension UITableViewCell: CellIdentifiable {
  
  static var cellReuseIdentifier: String {
    return String(describing: self)
  }
  
}
