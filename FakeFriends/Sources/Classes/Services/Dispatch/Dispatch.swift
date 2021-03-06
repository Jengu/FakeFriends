//
//  Dispatch.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 30.09.16.
//  Copyright © 2016 Jengu. All rights reserved.
//

import Foundation

struct Dispatch {
  
  static func performInBackground(block: @escaping () -> Void) {
    let concurrentQueue = DispatchQueue(label: "background", qos: .background)
    concurrentQueue.async {
      block()
    }
  }
  
  static func performInMainQueue(block: @escaping () -> Void) {
    DispatchQueue.main.async {
      block()
    }
  }
  
}
