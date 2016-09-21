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
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configure()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = frame.size.width * 0.5
  }
  
  private func configure() {
    layer.masksToBounds = true
    layer.borderColor = UIColor.black.cgColor
    layer.borderWidth = 2
  }
  
}
