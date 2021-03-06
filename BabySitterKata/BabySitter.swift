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
    
    startTime = nil
    endTime = nil
    dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = dateFormat
    
    fivePMStartTimeLimit = dateFormatter.dateFromString("2016-03-01 17:00:00")
    fourAMEndTimeLimit = dateFormatter.dateFromString("2016-03-02 04:00:00")
    midnight = dateFormatter.dateFromString("2016-03-02 00:00:00")
    
  }
  
  deinit {
    print("deinit babysitter...")
  }
  
  // MARK: Properties
  var startTime: NSDate?
  var endTime: NSDate?
  let dateFormat = "yyyy-mm-dd HH:mm:ss"
  var dateFormatter: NSDateFormatter!
  
  let fivePMStartTimeLimit: NSDate!
  let fourAMEndTimeLimit: NSDate!
  let midnight: NSDate!
  
  let pmDate = "2016-03-01"
  let amDate = "2016-03-02"
  
  let fivePMToBedTimePayRate: Double = 12
  let bedTimeToMidnightPayRate: Double = 8
  let midnightTo4AMPayRate: Double = 16
  
  let secondsPerHour: Double = 3600
  
}

// MARK: - Work Time Validation
extension BabySitter {
  func setStartTime(startTime: NSDate) -> Bool {
    
    let compareResult = startTime.compare(fivePMStartTimeLimit)
    
    switch compareResult {
    case .OrderedAscending:   // startTime is earlier than 5PM
      return false
      
    case .OrderedSame, .OrderedDescending:  // startTime is equal to or later than 5PM
      self.startTime = startTime
      return true
    }
  }
  
  func setEndTime(endTime: NSDate) -> Bool {
    
    let compareResult = endTime.compare(fourAMEndTimeLimit)
    
    switch compareResult {
    case .OrderedSame, .OrderedAscending:   // endTime is equal to or earlier than 4AM
      self.endTime = endTime
      return true
      
    case .OrderedDescending:  // endTime is later than 4AM
      return false
    }
  }
  
}

// MARK: - Payment Functions
extension BabySitter {
  
  func calculatePayFromStartTimeToBedTime(startTime: NSDate, endTime: NSDate, bedTime: NSDate) -> Double {
    
    // Case startTime is later than bedTime, return zero pay
    if case .OrderedDescending = startTime.compare(bedTime) {
      return 0
    }
    
    // Case endTime is earlier than 5PM, return zero pay
    if case .OrderedAscending = endTime.compare(fivePMStartTimeLimit) {
      return 0
    }
    
    let timeWorkedInSeconds: NSTimeInterval
    
    let startTimeFivePMStartTimeLimit = startTime.compare(fivePMStartTimeLimit)
    let endTimeBedTimeCompareResult = endTime.compare(bedTime)
    
    switch (startTimeFivePMStartTimeLimit, endTimeBedTimeCompareResult) {
    case (.OrderedSame, .OrderedSame), (.OrderedSame, .OrderedDescending): // startTime equals 5PM, endTime equals or later than bedTime
      timeWorkedInSeconds = bedTime.timeIntervalSinceDate(fivePMStartTimeLimit)
      
    case (.OrderedSame, .OrderedAscending): // startTime equals 5PM, endTime earlier than bedTime
      timeWorkedInSeconds = endTime.timeIntervalSinceDate(fivePMStartTimeLimit)
      
    case (.OrderedAscending, .OrderedSame), (.OrderedAscending, .OrderedDescending): // startTime earlier than 5PM, endTime equals or later than bedTime
      timeWorkedInSeconds = bedTime.timeIntervalSinceDate(fivePMStartTimeLimit)
      
    case (.OrderedAscending, .OrderedAscending): // startTime earlier than 5PM, endTime earlier than bedTime
      timeWorkedInSeconds = endTime.timeIntervalSinceDate(fivePMStartTimeLimit)
      
    case (.OrderedDescending, .OrderedSame), (.OrderedDescending, .OrderedDescending): // startTime later than 5PM, endTime equals or later than bedTime
      timeWorkedInSeconds = bedTime.timeIntervalSinceDate(startTime)
      
    case (.OrderedDescending, .OrderedAscending): // startTime later than 5PM, endTime earlier than bedTime
      timeWorkedInSeconds = endTime.timeIntervalSinceDate(startTime)
    }
    
    // Final pay calculation
    let timeWorkedInHours: Double = floor(timeWorkedInSeconds/secondsPerHour)
    
    return timeWorkedInHours * fivePMToBedTimePayRate
    
  }
  
  func calculatePayFromBedTimeToMidnight(startTime: NSDate, endTime: NSDate, bedTime: NSDate) -> Double {
    
    // Case startTime is later than midnight, return zero pay
    if case .OrderedDescending = startTime.compare(midnight) {
      return 0
    }
    
    // Case endTime is earlier than bedTime, return zero pay
    if case .OrderedAscending = endTime.compare(bedTime) {
      return 0
    }
    
    let timeWorkedInSeconds: NSTimeInterval
    
    let startTimeBedTimeCompareResult = startTime.compare(bedTime)
    let endTimeMidnightCompareResult = endTime.compare(midnight)
    
    switch (startTimeBedTimeCompareResult, endTimeMidnightCompareResult) {
    case (.OrderedSame, .OrderedSame), (.OrderedSame, .OrderedDescending): // startTime is equal to bedTime, endTime is equal to or later than midnight
      timeWorkedInSeconds = midnight.timeIntervalSinceDate(bedTime)
      
    case (.OrderedSame, .OrderedAscending): // startTime is equal to bedTime, endTime is earlier than midnight
      timeWorkedInSeconds = endTime.timeIntervalSinceDate(bedTime)
      
    case (.OrderedAscending, .OrderedSame), (.OrderedAscending, .OrderedDescending): // startTime is earlier than bedTime, endTime is equal to or later than midnight
      timeWorkedInSeconds = midnight.timeIntervalSinceDate(bedTime)
      
    case (.OrderedAscending, .OrderedAscending): // startTime is earlier than bedTime, endTime is earlier than midnight
      timeWorkedInSeconds = endTime.timeIntervalSinceDate(bedTime)
      
    case (.OrderedDescending, .OrderedSame), (.OrderedDescending, .OrderedDescending): // startTime is later than bedTime, endTime is equal to or later than midnight
      timeWorkedInSeconds = midnight.timeIntervalSinceDate(startTime)
      
    case (.OrderedDescending, .OrderedAscending): // startTime is later than bedTime, endTime is earlier than midnight
      timeWorkedInSeconds = endTime.timeIntervalSinceDate(startTime)
    }
    
    // Final pay calculation
    let timeWorkedInHours: Double = floor(timeWorkedInSeconds/secondsPerHour)
    
    return timeWorkedInHours * bedTimeToMidnightPayRate
    
  }
  
  func calculatePayFromMidnightToEndOfJobTime(startTime: NSDate, endTime: NSDate) -> Double {
    
    // Case of endTime earlier than midnight, return zero pay
    if case .OrderedAscending = endTime.compare(midnight) {
      return 0
    }
    
    // Case of startTime later than endOfJobTime, return zero pay
    if case .OrderedDescending = startTime.compare(fourAMEndTimeLimit) {
      return 0
    }
    
    let timeWorkedInSeconds: NSTimeInterval
    
    let startTimeMidnightCompareResult = startTime.compare(midnight)
    let endTime4AMCompareResult = endTime.compare(fourAMEndTimeLimit)
    
    switch (startTimeMidnightCompareResult, endTime4AMCompareResult) {
    case (.OrderedSame, .OrderedSame), (.OrderedSame, .OrderedDescending): // startTime is equal to midnight, endTime is equal to or later than 4AM
      timeWorkedInSeconds = fourAMEndTimeLimit.timeIntervalSinceDate(midnight)
      
    case (.OrderedSame, .OrderedAscending): // startTime is equal to midnight, endTime is earlier than 4AM
      timeWorkedInSeconds = endTime.timeIntervalSinceDate(midnight)
      
    case (.OrderedDescending, .OrderedSame), (.OrderedDescending, .OrderedDescending): // startTime is later than midnight, endTime is equal to or later than 4AM
      timeWorkedInSeconds = fourAMEndTimeLimit.timeIntervalSinceDate(startTime)
      
    case (.OrderedDescending, .OrderedAscending): // startTime is later than midnight, endTime is earlier than 4AM
      timeWorkedInSeconds = endTime.timeIntervalSinceDate(startTime)
      
    case (.OrderedAscending, .OrderedSame), (.OrderedAscending, .OrderedDescending): // startTime is earlier than midnight, endTime is equal to or later than 4AM
      timeWorkedInSeconds = fourAMEndTimeLimit.timeIntervalSinceDate(midnight)
      
    case (.OrderedAscending, .OrderedAscending): // startTime is earlier than midnight, endTime is earlier than 4AM
      timeWorkedInSeconds = endTime.timeIntervalSinceDate(midnight)
    }
    
    // Final pay calculation
    let timeWorkedInHours: Double = floor(timeWorkedInSeconds/secondsPerHour)
    
    return timeWorkedInHours * midnightTo4AMPayRate
  }
}




















