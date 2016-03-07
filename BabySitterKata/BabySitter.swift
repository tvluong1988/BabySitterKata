//
//  BabySitter.swift
//  BabySitterKata
//
//  Created by Thinh Luong on 3/7/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import Foundation

class BabySitter {
  
  // MARK: Lifecycle
  init() {
    print("init babysitter...")
    
    self.startTime = nil
  }
  
  deinit {
    print("deinit babysitter...")
  }
  
  // MARK: Properties
  let startTime: NSDate?
}

extension BabySitter {
  func setStartTime(time: NSDate) -> Bool {
    return false
  }
}