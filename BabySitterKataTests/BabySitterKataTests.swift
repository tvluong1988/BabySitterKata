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
    
    // startTime earlier than 5PM
    if let startTime: NSDate = dateFormatter.dateFromString(pmDate + "01:00:00") {
      XCTAssert(babySitter.setStartTime(startTime) == false, "BabySitter started earlier than 5PM.")
    }
    
    // startTime equals to 5PM
    if let startTime: NSDate = dateFormatter.dateFromString(pmDate + "017:00:00") {
      XCTAssert(babySitter.setStartTime(startTime), "BabySitter started earlier than 5PM.")
    }
    
    // startTime later than 5PM
    if let startTime: NSDate = dateFormatter.dateFromString(pmDate + "22:00:00") {
      XCTAssert(babySitter.setStartTime(startTime), "BabySitter started earlier than 5PM.")
    }
    
  }
  
  func testsBabySitterLeavesNoLaterThan4AM() {
    
    // endTime earlier than 4AM
    if let endTime: NSDate = dateFormatter.dateFromString(amDate + "03:00:00") {
      XCTAssert(babySitter.setEndTime(endTime), "BabySitter left later than 4AM.")
    }
    
    // endTime equals to 4AM
    if let endTime: NSDate = dateFormatter.dateFromString(amDate + "04:00:00") {
      XCTAssert(babySitter.setEndTime(endTime) == false, "BabySitter left later than 4AM.")
    }
    
    // endTime later than 4AM
    if let endTime: NSDate = dateFormatter.dateFromString(amDate + "05:00:00") {
      XCTAssert(babySitter.setEndTime(endTime) == false, "BabySitter left later than 4AM.")
    }
    
  }
  
  func testsBabySitterCalculatePayFromStartTimeToBedTime() {
    
    let payRate = babySitter.fivePMToBedTimePayRate
    
    // startTime earlier than 5PM, endTime earlier than 5PM
    if let startTime: NSDate = dateFormatter.dateFromString(pmDate + "14:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString(pmDate + "16:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString(pmDate + "20:00:00") {
        
        let correctPay: Double = payRate * 0 // $12/hr for 0hr
        
        XCTAssert(babySitter.calculatePayFromStartTimeToBedTime(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromStartTimeToBedTime incorrect.")
    }
    
    // startTime earlier than 5PM, endTime earlier than bedTime
    if let startTime: NSDate = dateFormatter.dateFromString(pmDate + "14:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString(pmDate + "19:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString(pmDate + "20:00:00") {
        
        let correctPay: Double = payRate * 2 // $12/hr for 2hr
        
        XCTAssert(babySitter.calculatePayFromStartTimeToBedTime(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromStartTimeToBedTime incorrect.")
    }
    
    // startTime earlier than 5PM, endTime equals bedTime
    if let startTime: NSDate = dateFormatter.dateFromString(pmDate + "14:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString(pmDate + "20:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString(pmDate + "20:00:00") {
        
        let correctPay: Double = payRate * 3 // $12/hr for 2hr
        
        XCTAssert(babySitter.calculatePayFromStartTimeToBedTime(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromStartTimeToBedTime incorrect.")
    }
    
    // startTime earlier than 5PM, endTime later than bedTime
    if let startTime: NSDate = dateFormatter.dateFromString(pmDate + "14:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString(pmDate + "23:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString(pmDate + "20:00:00") {
        
        let correctPay: Double = payRate * 3 // $12/hr for 2hr
        
        XCTAssert(babySitter.calculatePayFromStartTimeToBedTime(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromStartTimeToBedTime incorrect.")
    }
    
    // startTime equal to 5PM, endTime earlier than bedTime
    if let startTime: NSDate = dateFormatter.dateFromString(pmDate + "17:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString(pmDate + "19:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString(pmDate + "20:00:00") {
        
        let correctPay: Double = payRate * 2 // $12/hr for 2hr
        
        XCTAssert(babySitter.calculatePayFromStartTimeToBedTime(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromStartTimeToBedTime incorrect.")
    }
    
    // startTime equal to 5PM, endTime equal to bedTime
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 17:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00") {
        
        let correctPay: Double = payRate * 3 // $12/hr for 3hr
        
        XCTAssert(babySitter.calculatePayFromStartTimeToBedTime(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromStartTimeToBedTime incorrect.")
    }
    
    
    
    // startTime equal to 5PM, endTime later than bedTime
    if let startTime: NSDate = dateFormatter.dateFromString(pmDate + "17:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString(pmDate + "23:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString(pmDate + "20:00:00") {
        
        let correctPay: Double = payRate * 3 // $12/hr for 3hr
        
        XCTAssert(babySitter.calculatePayFromStartTimeToBedTime(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromStartTimeToBedTime incorrect.")
    }
    
    // startTime later than 5PM, endTime earlier than bedTime
    if let startTime: NSDate = dateFormatter.dateFromString(pmDate + "18:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString(pmDate + "19:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString(pmDate + "20:00:00") {
        
        let correctPay: Double = payRate * 1 // $12/hr for 3hr
        
        XCTAssert(babySitter.calculatePayFromStartTimeToBedTime(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromStartTimeToBedTime incorrect.")
    }
    
    // startTime later than 5PM, endTime equals bedTime
    if let startTime: NSDate = dateFormatter.dateFromString(pmDate + "18:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString(pmDate + "20:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString(pmDate + "20:00:00") {
        
        let correctPay: Double = payRate * 2 // $12/hr for 3hr
        
        XCTAssert(babySitter.calculatePayFromStartTimeToBedTime(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromStartTimeToBedTime incorrect.")
    }
    
    // startTime later than 5PM, endTime later than bedTime
    if let startTime: NSDate = dateFormatter.dateFromString(pmDate + "18:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString(pmDate + "23:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString(pmDate + "20:00:00") {
        
        let correctPay: Double = payRate * 1 // $12/hr for 3hr
        
        XCTAssert(babySitter.calculatePayFromStartTimeToBedTime(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromStartTimeToBedTime incorrect.")
    }
    
    // startTime later than bedTime, endTime later than bedTime
    if let startTime: NSDate = dateFormatter.dateFromString(pmDate + "21:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString(pmDate + "23:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString(pmDate + "20:00:00") {
        
        let correctPay: Double = payRate * 0 // $12/hr for 0hr
        
        XCTAssert(babySitter.calculatePayFromStartTimeToBedTime(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromStartTimeToBedTime incorrect.")
    }
    
    
    
  }
  
  func testsBabySitterCalculatePayFromBedTimeToMidnight() {
    
    let payRate = babySitter.bedTimeToMidnightPayRate
    
    // startTime earlier than bedTime, endTime earlier than bedTime
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 13:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-01 18:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00") {
        
        let correctPay: Double = payRate * 0 // $8/hr for 0hr
        
        XCTAssert(babySitter.calculatePayFromBedTimeToMidnight(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromBedTimeToMidnight incorrect.")
    }
    
    // startTime earlier than bedTime, endTime equals bedTime
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 15:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00") {
        
        let correctPay: Double = payRate * 0 // $8/hr for 0hr
        
        XCTAssert(babySitter.calculatePayFromBedTimeToMidnight(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromBedTimeToMidnight incorrect.")
    }
    
    // startTime earlier than bedTime, endTime later than bedTime but before midnight
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 15:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-01 23:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00") {
        
        let correctPay: Double = payRate * 3 // $8/hr for 3hr
        
        XCTAssert(babySitter.calculatePayFromBedTimeToMidnight(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromBedTimeToMidnight incorrect.")
    }
    
    // startTime earlier than bedTime, endTime later than bedTime pass midnight
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 15:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-02 03:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00") {
        
        let correctPay: Double = payRate * 4 // $8/hr for 4hr
        
        XCTAssert(babySitter.calculatePayFromBedTimeToMidnight(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromBedTimeToMidnight incorrect.")
    }
    
    // startTime later than bedTime, endTime later than bedTime but before midnight
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 21:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-01 23:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00") {
        
        let correctPay: Double = payRate * 2 // $8/hr for 2hr
        
        XCTAssert(babySitter.calculatePayFromBedTimeToMidnight(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromBedTimeToMidnight incorrect.")
    }
    
    // startTime later than bedTime, endTime equals midnight
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 21:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-02 00:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00") {
        
        let correctPay: Double = payRate * 3 // $8/hr for 3hr
        
        XCTAssert(babySitter.calculatePayFromBedTimeToMidnight(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromBedTimeToMidnight incorrect.")
    }
    
    // startTime later than bedTime, endTime later than bedTime pass midnight
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 21:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-02 03:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00") {
        
        let correctPay: Double = payRate * 3 // $8/hr for 3hr
        
        XCTAssert(babySitter.calculatePayFromBedTimeToMidnight(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromBedTimeToMidnight incorrect.")
    }
    
    // startTime later than midnight, endTime later than startTime
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-02 02:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-02 03:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00") {
        
        let correctPay: Double = payRate * 0 // $8/hr for 0hr
        
        XCTAssert(babySitter.calculatePayFromBedTimeToMidnight(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromBedTimeToMidnight incorrect.")
    }
    
  }
  
  func testsBabySitterCalculatePayFromMidnightToEndOfJobTime() {
    
    let payRate = babySitter.midnightTo4AMPayRate
    
    // startTime is earlier than midnight, endTime is earlier than midnight
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 17:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00") {
        
        let correctPay: Double = payRate * 0 // $16/hr for 0hr
        
        XCTAssert(babySitter.calculatePayFromMidnightToEndOfJobTime(startTime, endTime: endTime) == correctPay, "BabySitter calculatePayFromMidnightToEndOfJobTime incorrect.")
    }
    
    // startTime is later than endOfJobTime, endTime is later than startTime
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-02 06:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-02 09:00:00") {
        
        let correctPay: Double = payRate * 0 // $16/hr for 0hr
        
        XCTAssert(babySitter.calculatePayFromMidnightToEndOfJobTime(startTime, endTime: endTime) == correctPay, "BabySitter calculatePayFromMidnightToEndOfJobTime incorrect.")
    }
    
    // startTime is earlier than midnight, endTime is earlier than endOfJobTime
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 17:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-02 03:00:00") {
        
        let correctPay: Double = payRate * 3 // $16/hr for 3hr
        
        XCTAssert(babySitter.calculatePayFromMidnightToEndOfJobTime(startTime, endTime: endTime) == correctPay, "BabySitter calculatePayFromMidnightToEndOfJobTime incorrect.")
    }
    
    // startTime is earlier than midnight, endTime is equal to endOfJobTime
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 17:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-02 04:00:00") {
        
        let correctPay: Double = payRate * 4 // $16/hr for 4hr
        
        XCTAssert(babySitter.calculatePayFromMidnightToEndOfJobTime(startTime, endTime: endTime) == correctPay, "BabySitter calculatePayFromMidnightToEndOfJobTime incorrect.")
    }
    
    
    // startTime is earlier than midnight, endTime is later than endOfJobTime
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 17:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-02 06:00:00") {
        
        let correctPay: Double = payRate * 4 // $16/hr for 4hr
        
        XCTAssert(babySitter.calculatePayFromMidnightToEndOfJobTime(startTime, endTime: endTime) == correctPay, "BabySitter calculatePayFromMidnightToEndOfJobTime incorrect.")
    }
    
    // startTime is later than midnight, endTime is earlier than endOfJobTime
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-02 01:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-02 03:00:00") {
        
        let correctPay: Double = payRate * 2 // $16/hr for 2hr
        
        XCTAssert(babySitter.calculatePayFromMidnightToEndOfJobTime(startTime, endTime: endTime) == correctPay, "BabySitter calculatePayFromMidnightToEndOfJobTime incorrect.")
    }
    
    // startTime is later than midnight, endTime is equal to endOfJobTime
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-02 01:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-02 04:00:00") {
        
        let correctPay: Double = payRate * 3 // $16/hr for 3hr
        
        XCTAssert(babySitter.calculatePayFromMidnightToEndOfJobTime(startTime, endTime: endTime) == correctPay, "BabySitter calculatePayFromMidnightToEndOfJobTime incorrect.")
    }
    
    // startTime is later than midnight, endTime is later than endOfJobTime
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-02 01:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-02 06:00:00") {
        
        let correctPay: Double = payRate * 3 // $16/hr for 3hr
        
        XCTAssert(babySitter.calculatePayFromMidnightToEndOfJobTime(startTime, endTime: endTime) == correctPay, "BabySitter calculatePayFromMidnightToEndOfJobTime incorrect.")
    }
    
  }
  
  func testsBabySitterCalculatePayFromStartTimeToBedTimeFractionalHours() {
    
    let payRate = babySitter.fivePMToBedTimePayRate
    
    // Worked 2 hours
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 17:30:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-01 19:30:00"),
      let bedTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00") {
        
        let correctPay: Double = payRate * 2
        
        XCTAssert(babySitter.calculatePayFromStartTimeToBedTime(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromStartTimeToBedTime incorrect.")
    }
    
    // Worked 2.5 hours
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 17:30:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00") {
        
        let correctPay: Double = payRate * 2
        
        XCTAssert(babySitter.calculatePayFromStartTimeToBedTime(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromStartTimeToBedTime incorrect.")
    }
    
  }
  
  func testsBabySitterCalculatePayFromBedTimeToMidnightFractionalHours() {
    
    let payRate = babySitter.bedTimeToMidnightPayRate
    
    // Worked 2 hours
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 17:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-01 22:00:00"),
      let bedTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00") {
        
        let correctPay: Double = payRate * 2
        
        XCTAssert(babySitter.calculatePayFromBedTimeToMidnight(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromBedTimeToMidnight incorrect.")
    }
    
    // Worked 2.5 hours
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 21:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-01 23:30:00"),
      let bedTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00") {
        
        let correctPay: Double = payRate * 2
        
        XCTAssert(babySitter.calculatePayFromBedTimeToMidnight(startTime, endTime: endTime, bedTime: bedTime) == correctPay, "BabySitter calculatePayFromBedTimeToMidnight incorrect.")
    }
    
  }
  
  func testsBabySitterCalculatePayFromMidnightToEndOfJobTimeFractionalHours() {
    
    let payRate = babySitter.midnightTo4AMPayRate
    
    // Worked 2 hours
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-02 01:15:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-02 03:15:00") {
        
        let correctPay: Double = payRate * 2
        
        XCTAssert(babySitter.calculatePayFromMidnightToEndOfJobTime(startTime, endTime: endTime) == correctPay, "BabySitter calculatePayFromMidnightToEndOfJobTime incorrect.")
    }
    
    // Worked 2.5 hours
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-02 01:15:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-02 03:45:00") {
        
        let correctPay: Double = payRate * 2
        
        XCTAssert(babySitter.calculatePayFromMidnightToEndOfJobTime(startTime, endTime: endTime) == correctPay, "BabySitter calculatePayFromMidnightToEndOfJobTime incorrect.")
    }
    
  }
  
  func testsBabySitterSchedules() {
    let babySitter = BabySitter()
    
    let dateFormat = "yyyy-mm-dd HH:mm:ss"
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = dateFormat
    
    let bedTime: NSDate = dateFormatter.dateFromString("2016-03-01 20:00:00")!
    let midnight: NSDate = dateFormatter.dateFromString("2016-03-02 00:00:00")!
    
    let preBedTimePay: Double = 12
    let postBedTimePay: Double = 8
    let postMidnightPay: Double = 16
    
    // startTime is earlier than 5PM, endTime is later than 4AM
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 15:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-02 08:00:00")
    {
      
      let correctPay: Double = preBedTimePay * 3 + postBedTimePay * 4 + postMidnightPay * 4
      
      let calculatedPreBedTimePay = babySitter.calculatePayFromStartTimeToBedTime(startTime, endTime: endTime, bedTime: bedTime)
      let calculatedPostBedTimePay = babySitter.calculatePayFromBedTimeToMidnight(startTime, endTime: endTime, bedTime: bedTime)
      let calculatedPostMidnightPay = babySitter.calculatePayFromMidnightToEndOfJobTime(startTime, endTime: endTime)
      
      let totalCalculatedPay = calculatedPreBedTimePay + calculatedPostBedTimePay + calculatedPostMidnightPay
      
      print("Correct pay: \(correctPay)")
      print("\(calculatedPreBedTimePay), \(calculatedPostBedTimePay), \(calculatedPostMidnightPay), \(totalCalculatedPay)")
      
      XCTAssert(totalCalculatedPay == correctPay, "Total calculated pay is incorrect.")
    }
    
    // startTime is earlier than 5PM, endTime is later than betTime but before midnight
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 15:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-01 23:00:00")
    {
      
      let correctPay: Double = preBedTimePay * 3 + postBedTimePay * 3 + postMidnightPay * 0
      
      let calculatedPreBedTimePay = babySitter.calculatePayFromStartTimeToBedTime(startTime, endTime: endTime, bedTime: bedTime)
      let calculatedPostBedTimePay = babySitter.calculatePayFromBedTimeToMidnight(startTime, endTime: endTime, bedTime: bedTime)
      let calculatedPostMidnightPay = babySitter.calculatePayFromMidnightToEndOfJobTime(startTime, endTime: endTime)
      
      let totalCalculatedPay = calculatedPreBedTimePay + calculatedPostBedTimePay + calculatedPostMidnightPay
      
      print("Correct pay: \(correctPay)")
      print("\(calculatedPreBedTimePay), \(calculatedPostBedTimePay), \(calculatedPostMidnightPay), \(totalCalculatedPay)")
      
      XCTAssert(totalCalculatedPay == correctPay, "Total calculated pay is incorrect.")
    }
    
    // startTime is later than 5PM but earlier than bedTime, endTime is later than 4AM
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 18:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-02 08:00:00")
    {
      
      let correctPay: Double = preBedTimePay * 2 + postBedTimePay * 4 + postMidnightPay * 4
      
      let calculatedPreBedTimePay = babySitter.calculatePayFromStartTimeToBedTime(startTime, endTime: endTime, bedTime: bedTime)
      let calculatedPostBedTimePay = babySitter.calculatePayFromBedTimeToMidnight(startTime, endTime: endTime, bedTime: bedTime)
      let calculatedPostMidnightPay = babySitter.calculatePayFromMidnightToEndOfJobTime(startTime, endTime: endTime)
      
      let totalCalculatedPay = calculatedPreBedTimePay + calculatedPostBedTimePay + calculatedPostMidnightPay
      
      print("Correct pay: \(correctPay)")
      print("\(calculatedPreBedTimePay), \(calculatedPostBedTimePay), \(calculatedPostMidnightPay), \(totalCalculatedPay)")
      
      XCTAssert(totalCalculatedPay == correctPay, "Total calculated pay is incorrect.")
    }
    
    // startTime is later than bedTime, endTime is later than 4AM
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-01 22:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-02 08:00:00")
    {
      
      let correctPay: Double = preBedTimePay * 0 + postBedTimePay * 2 + postMidnightPay * 4
      
      let calculatedPreBedTimePay = babySitter.calculatePayFromStartTimeToBedTime(startTime, endTime: endTime, bedTime: bedTime)
      let calculatedPostBedTimePay = babySitter.calculatePayFromBedTimeToMidnight(startTime, endTime: endTime, bedTime: bedTime)
      let calculatedPostMidnightPay = babySitter.calculatePayFromMidnightToEndOfJobTime(startTime, endTime: endTime)
      
      let totalCalculatedPay = calculatedPreBedTimePay + calculatedPostBedTimePay + calculatedPostMidnightPay
      
      print("Correct pay: \(correctPay)")
      print("\(calculatedPreBedTimePay), \(calculatedPostBedTimePay), \(calculatedPostMidnightPay), \(totalCalculatedPay)")
      
      XCTAssert(totalCalculatedPay == correctPay, "Total calculated pay is incorrect.")
    }
    
    // startTime is later than midnight, endTime is later than 4AM
    if let startTime: NSDate = dateFormatter.dateFromString("2016-03-02 01:00:00"),
      let endTime: NSDate = dateFormatter.dateFromString("2016-03-02 08:00:00")
    {
      
      let correctPay: Double = preBedTimePay * 0 + postBedTimePay * 0 + postMidnightPay * 3
      
      let calculatedPreBedTimePay = babySitter.calculatePayFromStartTimeToBedTime(startTime, endTime: endTime, bedTime: bedTime)
      let calculatedPostBedTimePay = babySitter.calculatePayFromBedTimeToMidnight(startTime, endTime: endTime, bedTime: bedTime)
      let calculatedPostMidnightPay = babySitter.calculatePayFromMidnightToEndOfJobTime(startTime, endTime: endTime)
      
      let totalCalculatedPay = calculatedPreBedTimePay + calculatedPostBedTimePay + calculatedPostMidnightPay
      
      print("Correct pay: \(correctPay)")
      print("\(calculatedPreBedTimePay), \(calculatedPostBedTimePay), \(calculatedPostMidnightPay), \(totalCalculatedPay)")
      
      XCTAssert(totalCalculatedPay == correctPay, "Total calculated pay is incorrect.")
    }
    
  }
  
  // MARK: Lifecycle
  override func setUp() {
    super.setUp()
    
    babySitter = BabySitter()
    dateFormatter = babySitter.dateFormatter
    amDate = babySitter.amDate
    pmDate = babySitter.pmDate
  }
  
  override func tearDown() {
    //    dateFormatter = nil
    //    amDate = nil
    //    pmDate = nil
    //    babySitter = nil
    
    super.tearDown()
  }
  
  // MARK: Properties
  var babySitter: BabySitter!
  var dateFormatter: NSDateFormatter!
  var amDate: String!
  var pmDate: String!
}


























