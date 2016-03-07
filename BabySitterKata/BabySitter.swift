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
    self.endTime = nil
  }
  
  deinit {
    print("deinit babysitter...")
  }
  
  // MARK: Properties
  var startTime: NSDate?
  var endTime: NSDate?
}

// MARK: - Helpers
extension BabySitter {
  func setStartTime(startTime: NSDate) -> Bool {
    
    let dateFormat = "HH:mm:ss"
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = dateFormat
    
    guard let fivePMStartTimeLimit: NSDate = dateFormatter.dateFromString("17:00:00") else {
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
  
  func setEndTime(endTime: NSDate) -> Bool {
    let dateFormat = "HH:mm:ss"
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = dateFormat
    
    guard let fourAMTimeLimit: NSDate = dateFormatter.dateFromString("04:00:00") else {
      return false
    }
    
    let compareResult = endTime.compare(fourAMTimeLimit)
    
    switch compareResult {
    case .OrderedAscending:   // endTime is earlier than 4AM
      self.endTime = endTime
      return true
      
    case .OrderedDescending:  // endTime is later than 4AM
      return false
      
    case .OrderedSame:        // endTime is equal to 4AM
      self.endTime = endTime
      return false
    }
    
    
  }
}






















