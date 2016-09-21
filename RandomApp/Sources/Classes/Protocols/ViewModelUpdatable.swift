//
//  ViewModelUpdatable.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 21.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import Foundation

protocol ViewModelUpdatable {
  
  associatedtype ViewModel
  
  func update(with viewModel: ViewModel)
  
}
