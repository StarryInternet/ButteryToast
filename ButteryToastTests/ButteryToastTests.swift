//
//  ButteryToastTests.swift
//  ButteryToastTests
//
//  Created by creisterer on 11/3/15.
//  Copyright © 2015 Starry. All rights reserved.
//

import XCTest
@testable import ButteryToast

class ButteryToastTests: XCTestCase {

  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testClearingToast() {
    let toast = Toast(view: UIView())
    Toaster.sharedInstance.prepareToast(toast)
    let cleared = Toaster.sharedInstance.clearMessage(toast)
    XCTAssertTrue(cleared)
  }



}
