//
//  UserEmailMapperTest.swift
//  
//
//  Created by Rihan on 21/12/22.
//

import XCTest
@testable import WigzoiOSSDK

final class EmailMapperTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPositive() throws {
        let userEmailMapper : UserEmailMapper = UserEmailMapper(email: "jay@son.com")
        try! userEmailMapper.push()
    }
    
    func testNegativeNoEmail() throws {
        let userEmailMapper : UserEmailMapper = UserEmailMapper(email: "")
        XCTAssertThrowsError(try userEmailMapper.push())
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
