//
//  DeviceMapperTest.swift
//  
//
//  Created by Rihan on 20/12/22.
//

import XCTest

@testable import WigzoiOSSDK

final class DeviceMapperTest: XCTestCase {
    
    private static var ORG_TOKEN = "F4Ng7g0gQDeIBgHBHRXkDQ"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPositive() throws {
        try Wigzo.initialize(orgToken: DeviceMapperTest.ORG_TOKEN, forceInit: true)
    }
    
    func testNegativeNoOrgToken() throws {
        XCTAssertThrowsError(try Wigzo.initialize(orgToken: "", forceInit: true))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
