//
//  ViewModellable.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 20.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import Foundation

protocol ViewModellable {
  
  associatedtype ViewModel
  
  var viewModel: ViewModel { get }
  
  init(viewModel: ViewModel)
  
}
