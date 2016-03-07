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
    
    if let startTime: NSDate = dateFormatter.dateFromString("01:00:22") {
      XCTAssert(babySitter.setStartTime(startTime) == false, "BabySitter started earlier than 5PM.")
    }
    
    if let startTime: NSDate = dateFormatter.dateFromString("05:00:00") {
      XCTAssert(babySitter.setStartTime(startTime), "BabySitter started later than 5PM.")
    }
    
    if let startTime: NSDate = dateFormatter.dateFromString("09:44:22") {
      XCTAssert(babySitter.setStartTime(startTime), "BabySitter started later than 5PM.")
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
