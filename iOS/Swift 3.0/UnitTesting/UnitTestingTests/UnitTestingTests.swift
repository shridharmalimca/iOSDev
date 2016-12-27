//
//  UnitTestingTests.swift
//  UnitTestingTests
//
//  Created by Shridhar Mali on 12/27/16.
//  Copyright © 2016 TIS. All rights reserved.
//

import XCTest
@testable import UnitTesting

class UnitTestingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIsNumberIsEven() {
        let vc = ViewController()
        XCTAssertFalse(vc.isNumberEven(num: 1))
        
    }
    
    func testExample() {
        
        
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
