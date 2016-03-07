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

// MARK: - Work Time
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


// MARK: - Payment Functions
extension BabySitter {
  
  func calculatePayFromStartTimeToBedTime(startTime: NSDate, endTime: NSDate, bedTime: NSDate) -> Double {
    let secondsPerHour: Double = 3600
    let payRate: Double = 12
    
    
    let compareResult = endTime.compare(bedTime)
    
    switch compareResult {
    case .OrderedSame:        // endTime is equal to bedTime
      let timeWorkedInSeconds: NSTimeInterval = bedTime.timeIntervalSinceDate(startTime)
      
      let timeWorkedInHours: Double = floor(timeWorkedInSeconds/secondsPerHour)
      
      let pay = timeWorkedInHours * payRate
      
      return pay
      
    case .OrderedAscending:   // endTime is earlier than bedTime
      let timeWorkedInSeconds: NSTimeInterval = endTime.timeIntervalSinceDate(startTime)
      
      let timeWorkedInHours: Double = floor(timeWorkedInSeconds/secondsPerHour)
      
      let pay = timeWorkedInHours * payRate
      
      return pay
      
    case .OrderedDescending:  // endTime is later than bedTime
      let timeWorkedInSeconds: NSTimeInterval = bedTime.timeIntervalSinceDate(startTime)
      
      let timeWorkedInHours: Double = floor(timeWorkedInSeconds/secondsPerHour)
      
      let pay = timeWorkedInHours * payRate
      
      return pay
    }
  }
  
  func calculatePayFromBedTimeToMidnight(startTime: NSDate, endTime: NSDate, bedTime: NSDate, midnight: NSDate) -> Double {
    
    // Case where startTime is pass midnight, therefore zero pay.
    if case .OrderedDescending = startTime.compare(midnight) {
      return 0
    }
    
    
    let secondsPerHour: Double = 3600
    let payRate: Double = 8
    
    
    let startTimeBedTimeCompare = startTime.compare(bedTime)
    
    switch startTimeBedTimeCompare {
    case .OrderedSame: // startTime equals to bedTime
      let endTimeMidnightCompare = endTime.compare(midnight)
      
      switch endTimeMidnightCompare {
      case .OrderedSame:  // endTime equal to midnight
        let timeWorkedInSeconds: NSTimeInterval = midnight.timeIntervalSinceDate(bedTime)
        
        let timeWorkedInHours: Double = floor(timeWorkedInSeconds/secondsPerHour)
        
        let pay = timeWorkedInHours * payRate
        
        return pay
        
      case .OrderedAscending:   // endTime earlier than midnight
        let timeWorkedInSeconds: NSTimeInterval = endTime.timeIntervalSinceDate(bedTime)
        
        let timeWorkedInHours: Double = floor(timeWorkedInSeconds/secondsPerHour)
        
        let pay = timeWorkedInHours * payRate
        
        return pay
        
      case .OrderedDescending:  // endTime later than midnight
        let timeWorkedInSeconds: NSTimeInterval = midnight.timeIntervalSinceDate(bedTime)
        
        let timeWorkedInHours: Double = floor(timeWorkedInSeconds/secondsPerHour)
        
        let pay = timeWorkedInHours * payRate
        
        return pay
      }
      
    case .OrderedAscending: // startTime earlier than bedTime
      let endTimeMidnightCompare = endTime.compare(midnight)
      
      switch endTimeMidnightCompare {
      case .OrderedSame:  // endTime equal to midnight
        let timeWorkedInSeconds: NSTimeInterval = midnight.timeIntervalSinceDate(bedTime)
        
        let timeWorkedInHours: Double = floor(timeWorkedInSeconds/secondsPerHour)
        
        let pay = timeWorkedInHours * payRate
        
        return pay
        
      case .OrderedAscending:   // endTime earlier than midnight
        let timeWorkedInSeconds: NSTimeInterval = endTime.timeIntervalSinceDate(bedTime)
        
        let timeWorkedInHours: Double = floor(timeWorkedInSeconds/secondsPerHour)
        
        let pay = timeWorkedInHours * payRate
        
        return pay
        
      case .OrderedDescending:  // endTime later than midnight
        let timeWorkedInSeconds: NSTimeInterval = midnight.timeIntervalSinceDate(bedTime)
        
        let timeWorkedInHours: Double = floor(timeWorkedInSeconds/secondsPerHour)
        
        let pay = timeWorkedInHours * payRate
        
        return pay
      }
      
    case .OrderedDescending:  // startTime later than betTime
      let endTimeMidnightCompare = endTime.compare(midnight)
      
      switch endTimeMidnightCompare {
      case .OrderedSame:  // endTime equal to midnight
        let timeWorkedInSeconds: NSTimeInterval = midnight.timeIntervalSinceDate(startTime)
        
        let timeWorkedInHours: Double = floor(timeWorkedInSeconds/secondsPerHour)
        
        let pay = timeWorkedInHours * payRate
        
        return pay
        
      case .OrderedAscending:   // endTime earlier than midnight
        let timeWorkedInSeconds: NSTimeInterval = endTime.timeIntervalSinceDate(startTime)
        
        let timeWorkedInHours: Double = floor(timeWorkedInSeconds/secondsPerHour)
        
        let pay = timeWorkedInHours * payRate
        
        return pay
        
      case .OrderedDescending:  // endTime later than midnight
        let timeWorkedInSeconds: NSTimeInterval = midnight.timeIntervalSinceDate(startTime)
        
        let timeWorkedInHours: Double = floor(timeWorkedInSeconds/secondsPerHour)
        
        let pay = timeWorkedInHours * payRate
        
        return pay
      }
    }
    
  }
  
  func calculatePayFromMidnightToEndOfJobTime(startTime: NSDate, endTime: NSDate, midnight: NSDate) -> Double {
    
    // Case of endTime earlier than midnight, return zero pay
    if case .OrderedAscending = endTime.compare(midnight) {
      return 0
    }
    
    let secondsPerHour: Double = 3600
    let payRate: Double = 16
    
    let dateFormat = "yyyy-mm-dd HH:mm:ss"
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = dateFormat
    
    let fourAMTimeLimit: NSDate = dateFormatter.dateFromString("2016-03-02 04:00:00")!
    
    
    let startTimeMidnightCompare = startTime.compare(midnight)
    
    switch startTimeMidnightCompare {
    case .OrderedSame:  // startTime equal to midnight
      
      let endTimeFourAMTimeLimitCompare = endTime.compare(fourAMTimeLimit)
      
      switch endTimeFourAMTimeLimitCompare {
      case .OrderedSame: // endTime equal to 4AM
        let timeWorkedInSeconds: NSTimeInterval = fourAMTimeLimit.timeIntervalSinceDate(midnight)
        
        let timeWorkedInHours: Double = floor(timeWorkedInSeconds/secondsPerHour)
        
        let pay = timeWorkedInHours * payRate
        
        return pay
        
      case .OrderedAscending:   // endTime earlier than 4AM
        let timeWorkedInSeconds: NSTimeInterval = endTime.timeIntervalSinceDate(midnight)
        
        let timeWorkedInHours: Double = floor(timeWorkedInSeconds/secondsPerHour)
        
        let pay = timeWorkedInHours * payRate
        
        return pay
        
      case .OrderedDescending:  // endTime later than 4AM
        let timeWorkedInSeconds: NSTimeInterval = fourAMTimeLimit.timeIntervalSinceDate(midnight)
        
        let timeWorkedInHours: Double = floor(timeWorkedInSeconds/secondsPerHour)
        
        let pay = timeWorkedInHours * payRate
        
        return pay
      }
      
    case .OrderedAscending:   // startTime earlier than midnight
      let endTimeFourAMTimeLimitCompare = endTime.compare(fourAMTimeLimit)
      
      switch endTimeFourAMTimeLimitCompare {
      case .OrderedSame: // endTime equal to 4AM
        let timeWorkedInSeconds: NSTimeInterval = fourAMTimeLimit.timeIntervalSinceDate(midnight)
        
        let timeWorkedInHours: Double = floor(timeWorkedInSeconds/secondsPerHour)
        
        let pay = timeWorkedInHours * payRate
        
        return pay
        
      case .OrderedAscending:   // endTime earlier than 4AM
        let timeWorkedInSeconds: NSTimeInterval = endTime.timeIntervalSinceDate(midnight)
        
        let timeWorkedInHours: Double = floor(timeWorkedInSeconds/secondsPerHour)
        
        let pay = timeWorkedInHours * payRate
        
        return pay
        
      case .OrderedDescending:  // endTime later than 4AM
        let timeWorkedInSeconds: NSTimeInterval = fourAMTimeLimit.timeIntervalSinceDate(midnight)
        
        let timeWorkedInHours: Double = floor(timeWorkedInSeconds/secondsPerHour)
        
        let pay = timeWorkedInHours * payRate
        
        return pay
      }
      
    case .OrderedDescending:  // startTime later than midnight
      let endTimeFourAMTimeLimitCompare = endTime.compare(fourAMTimeLimit)
      
      switch endTimeFourAMTimeLimitCompare {
      case .OrderedSame: // endTime equal to 4AM
        let timeWorkedInSeconds: NSTimeInterval = fourAMTimeLimit.timeIntervalSinceDate(startTime)
        
        let timeWorkedInHours: Double = floor(timeWorkedInSeconds/secondsPerHour)
        
        let pay = timeWorkedInHours * payRate
        
        return pay
        
      case .OrderedAscending:   // endTime earlier than 4AM
        let timeWorkedInSeconds: NSTimeInterval = endTime.timeIntervalSinceDate(startTime)
        
        let timeWorkedInHours: Double = floor(timeWorkedInSeconds/secondsPerHour)
        
        let pay = timeWorkedInHours * payRate
        
        return pay
        
      case .OrderedDescending:  // endTime later than 4AM
        let timeWorkedInSeconds: NSTimeInterval = fourAMTimeLimit.timeIntervalSinceDate(startTime)
        
        let timeWorkedInHours: Double = floor(timeWorkedInSeconds/secondsPerHour)
        
        let pay = timeWorkedInHours * payRate
        
        return pay
      }
    }
    
  }
}




















