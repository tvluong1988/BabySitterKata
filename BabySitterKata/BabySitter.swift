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
  var startTime: NSDate?
}

// MARK: - Helpers
extension BabySitter {
  func setStartTime(startTime: NSDate) -> Bool {
    
    let dateFormat = "HH:mm:ss"
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = dateFormat
    
    guard let fivePMStartTimeLimit: NSDate = dateFormatter.dateFromString("05:00:00") else {
      return false
    }
    
    let compareResult = startTime.compare(fivePMStartTimeLimit)
    
    switch compareResult {
    case .OrderedAscending:   // startTime is earlier than 5PM
      return false
      
    case .OrderedDescending:  // startTime is later than 5PM
      self.startTime = startTime
      return true
      
    case .OrderedSame:        // startTime is equal to 5PM
      self.startTime = startTime
      return true
    }
    
  }
}






















