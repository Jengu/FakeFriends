//
//  AvatarImageView.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 22.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import Foundation
import UIKit

class AvatarImageView: UIImageView {
  
  struct Constants {
    static let cornerRadiusMultiplier: CGFloat = 0.5
    static let borderWidth: CGFloat = 1
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configure()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = frame.size.width * Constants.cornerRadiusMultiplier
  }
  
  private func configure() {
    layer.masksToBounds = true
    layer.borderColor = UIColor.lightGray.cgColor
    layer.borderWidth = Constants.borderWidth
  }
  
}
