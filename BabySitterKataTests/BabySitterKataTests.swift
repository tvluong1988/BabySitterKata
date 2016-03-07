//
//  BabySitterKataTests.swift
//  BabySitterKataTests
//
//  Created by Thinh Luong on 3/7/16.
//  Copyright © 2016 Thinh Luong. All rights reserved.
//

import XCTest
@testable import BabySitterKata

class BabySitterKataTests: XCTestCase {
  
  // MARK: Tests
  func testsBabySitterInit() {
    var babySitter: BabySitter?  = BabySitter()
    babySitter = nil
  }
  
  func testsBabySitterStartsNoEarlierThan5PM() {
    
    let babySitter = BabySitter()
    
    let dateFormat = "HH:mm:ss"
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = dateFormat
    
    // startTime earlier than 5PM
    if let startTime: NSDate = dateFormatter.dateFromString("01:00:22") {
      XCTAssert(babySitter.setStartTime(startTime) == false, "BabySitter started earlier than 5PM.")
    }
    
    // startTime equals to 5PM
    if let startTime: NSDate = dateFormatter.dateFromString("017:00:00") {
      XCTAssert(babySitter.setStartTime(startTime), "BabySitter started earlier than 5PM.")
    }
    
    // startTime later than 5PM
    if let startTime: NSDate = dateFormatter.dateFromString("22:44:22") {
      XCTAssert(babySitter.setStartTime(startTime), "BabySitter started earlier than 5PM.")
    }
    
  }
  
  func testsBabySitterLeavesNoLaterThan4AM() {
    let babySitter = BabySitter()
    
    let dateFormat = "HH:mm:ss"
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = dateFormat
    
    // endTime earlier than 4AM
    if let endTime: NSDate = dateFormatter.dateFromString("03:33:44") {
      XCTAssert(babySitter.setEndTime(endTime), "BabySitter left later than 4AM.")
    }
    
    // endTime equals to 4AM
    if let endTime: NSDate = dateFormatter.dateFromString("04:00:00") {
      XCTAssert(babySitter.setEndTime(endTime) == false, "BabySitter left later than 4AM.")
    }
    
    // endTime later than 4AM
    if let endTime: NSDate = dateFormatter.dateFromString("05:33:44") {
      XCTAssert(babySitter.setEndTime(endTime) == false, "BabySitter left later than 4AM.")
    }
    
  }
  
  func testsBabySitterCalculatePayFromStartTimeToBedTime() {
    let babySitter = BabySitter()
    
    let dateFormat = "HH:mm:ss"
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = dateFormat
    
    // endTime equals bedTime
    if let startTime: NSDate = dateFormatter.dateFromString("17:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("20:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString("20:00:00") {
        
        let correctPay: Double = 12 * 3 // $12/hr for 3hr
        
        XCTAssert(babySitter.calculatePayFromStartTimeToBedTime(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromStartTimeToBedTime incorrect.")
    }
    
    // endTime earlier than bedTime
    if let startTime: NSDate = dateFormatter.dateFromString("17:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("19:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString("20:00:00") {
        
        let correctPay: Double = 12 * 2 // $12/hr for 2hr
        
        XCTAssert(babySitter.calculatePayFromStartTimeToBedTime(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromStartTimeToBedTime incorrect.")
    }
    
    // endTime later than bedTime
    if let startTime: NSDate = dateFormatter.dateFromString("17:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("22:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString("20:00:00") {
        
        let correctPay: Double = 12 * 3 // $12/hr for 3hr
        
        XCTAssert(babySitter.calculatePayFromStartTimeToBedTime(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromStartTimeToBedTime incorrect.")
    }
    
  }
  
  func testsBabySitterCalculatePayFromBedTimeToMidnight() {
    let babySitter = BabySitter()
    
    let dateFormat = "yyyy-mm-dd HH:mm:ss"
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = dateFormat
    
    // startTime earlier than bedTime, endTime equals bedTime
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 17:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00"),
      let midnight: NSDate = dateFormatter.dateFromString("2016-03-02 00:00:00") {
        
        let correctPay: Double = 8 * 0 // $12/hr for 0hr
        
        XCTAssert(babySitter.calculatePayFromBedTimeToMidnight(startTime, endTime: endTime, bedTime: bedTime, midnight: midnight) == correctPay, "BabySitter calculatePayFromBedTimeToMidnight incorrect.")
    }
    
    // startTime earlier than bedTime, endTime later than bedTime but before midnight
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 17:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-01 23:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00"),
      let midnight: NSDate = dateFormatter.dateFromString("2016-03-02 00:00:00") {
        
        let correctPay: Double = 8 * 3 // $8/hr for 3hr
        
        XCTAssert(babySitter.calculatePayFromBedTimeToMidnight(startTime, endTime: endTime, bedTime: bedTime, midnight: midnight) == correctPay, "BabySitter calculatePayFromBedTimeToMidnight incorrect.")
    }
    
    // startTime earlier than bedTime, endTime later than bedTime pass midnight
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 17:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-02 03:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00"),
      let midnight: NSDate = dateFormatter.dateFromString("2016-03-02 00:00:00") {
        
        let correctPay: Double = 8 * 4 // $8/hr for 4hr
        
        XCTAssert(babySitter.calculatePayFromBedTimeToMidnight(startTime, endTime: endTime, bedTime: bedTime, midnight: midnight) == correctPay, "BabySitter calculatePayFromBedTimeToMidnight incorrect.")
    }
    
    // startTime later than bedTime, endTime later than bedTime but before midnight
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 21:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-01 23:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00"),
      let midnight: NSDate = dateFormatter.dateFromString("2016-03-02 00:00:00") {
        
        let correctPay: Double = 8 * 2 // $8/hr for 2hr
        
        XCTAssert(babySitter.calculatePayFromBedTimeToMidnight(startTime, endTime: endTime, bedTime: bedTime, midnight: midnight) == correctPay, "BabySitter calculatePayFromBedTimeToMidnight incorrect.")
    }
    
    // startTime later than bedTime, endTime later than bedTime pass midnight
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 21:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-02 03:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00"),
      let midnight: NSDate = dateFormatter.dateFromString("2016-03-02 00:00:00") {
        
        let correctPay: Double = 8 * 3 // $8/hr for 3hr
        
        XCTAssert(babySitter.calculatePayFromBedTimeToMidnight(startTime, endTime: endTime, bedTime: bedTime, midnight: midnight) == correctPay, "BabySitter calculatePayFromBedTimeToMidnight incorrect.")
    }
    
    // startTime later than midnight, endTime later than startTime
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-02 02:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-02 03:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00"),
      let midnight: NSDate = dateFormatter.dateFromString("2016-03-02 00:00:00") {
        
        let correctPay: Double = 8 * 0 // $8/hr for 0hr
        
        XCTAssert(babySitter.calculatePayFromBedTimeToMidnight(startTime, endTime: endTime, bedTime: bedTime, midnight: midnight) == correctPay, "BabySitter calculatePayFromBedTimeToMidnight incorrect.")
    }
    
  }
  
  func testsBabySitterCalculatePayFromMidnightToEndOfJobTime() {
    let babySitter = BabySitter()
    
    let dateFormat = "yyyy-mm-dd HH:mm:ss"
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = dateFormat
    
    // startTime is earlier than midnight, endTime is earlier than midnight
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 17:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00"),
      let midnight: NSDate = dateFormatter.dateFromString("2016-03-02 00:00:00") {
        
        let correctPay: Double = 16 * 0 // $16/hr for 0hr
        
        XCTAssert(babySitter.calculatePayFromMidnightToEndOfJobTime(startTime, endTime: endTime, midnight: midnight) == correctPay, "BabySitter calculatePayFromMidnightToEndOfJobTime incorrect.")
    }
    
    // startTime is earlier than midnight, endTime is earlier than endOfJobTime
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 17:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-02 03:00:00"),
      let midnight: NSDate = dateFormatter.dateFromString("2016-03-02 00:00:00") {
        
        let correctPay: Double = 16 * 3 // $16/hr for 3hr
        
        XCTAssert(babySitter.calculatePayFromMidnightToEndOfJobTime(startTime, endTime: endTime, midnight: midnight) == correctPay, "BabySitter calculatePayFromMidnightToEndOfJobTime incorrect.")
    }
    
    // startTime is earlier than midnight, endTime is later than endOfJobTime
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 17:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-02 06:00:00"),
      let midnight: NSDate = dateFormatter.dateFromString("2016-03-02 00:00:00") {
        
        let correctPay: Double = 16 * 4 // $16/hr for 4hr
        
        XCTAssert(babySitter.calculatePayFromMidnightToEndOfJobTime(startTime, endTime: endTime, midnight: midnight) == correctPay, "BabySitter calculatePayFromMidnightToEndOfJobTime incorrect.")
    }
    
    // startTime is later than midnight, endTime is earlier than endOfJobTime
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-02 01:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-02 03:00:00"),
      let midnight: NSDate = dateFormatter.dateFromString("2016-03-02 00:00:00") {
        
        let correctPay: Double = 16 * 2 // $16/hr for 2hr
        
        XCTAssert(babySitter.calculatePayFromMidnightToEndOfJobTime(startTime, endTime: endTime, midnight: midnight) == correctPay, "BabySitter calculatePayFromMidnightToEndOfJobTime incorrect.")
    }
    
    // startTime is later than midnight, endTime is later than endOfJobTime
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-02 01:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-02 06:00:00"),
      let midnight: NSDate = dateFormatter.dateFromString("2016-03-02 00:00:00") {
        
        let correctPay: Double = 16 * 3 // $16/hr for 2hr
        
        XCTAssert(babySitter.calculatePayFromMidnightToEndOfJobTime(startTime, endTime: endTime, midnight: midnight) == correctPay, "BabySitter calculatePayFromMidnightToEndOfJobTime incorrect.")
    }
    
  }
  
  // MARK: Lifecycle
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: Properties
}
