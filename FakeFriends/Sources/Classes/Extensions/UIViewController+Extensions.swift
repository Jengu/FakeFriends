//
//  UIViewController+Extensions.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 23.09.16.
//  Copyright © 2016 Jengu. All rights reserved.
//

import Foundation
import KRProgressHUD

extension UIViewController {
  
  //MARK: - HUD

  func showHUD() {
    KRProgressHUD.show()
  }
  
  func dismissHUD() {
    KRProgressHUD.dismiss()
  }
  
  //MARK: - Alert
  
  func showAlert(with error: Error) {
    showAlert(withTitle: "Error", message: error.localizedDescription)
  }
  
  func showAlert(withTitle title: String, message: String) {
    let alert = UIAlertController(title: title,
                                  message: message,
                                  preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
  
}
