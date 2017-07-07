//
//  LocationTests.swift
//  LocationTracking
//
//  Created by Shridhar Mali on 6/15/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import XCTest
@testable import LocationTracking

class LocationTests: XCTestCase {
   
    var sut: HomeViewController!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        _ = sut.view
    }
    
    func testMovieLibraryVC_ButtonShouldNotBeNil() {
        XCTAssertNotNil(sut.btn)
    }
    
    func testMovieLibraryVC_TableViewShouldNotBeNil() {
        XCTAssertNotNil(sut.btnLocationUpdate)
    }
    func testHomeViewController_LocationEableBtnShouldNotBeNil() {
        XCTAssertNotNil(sut.btnLocationUpdate)
    }
    
    func testHomeViewController_locationManagerHelperShouldNotBeNil() {
        XCTAssertNotNil(sut.locationManagerHelper)
    }
}
