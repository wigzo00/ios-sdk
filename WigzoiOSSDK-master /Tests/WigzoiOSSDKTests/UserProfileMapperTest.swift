//
//  UserProfileMapperTest.swift
//  
//
//  Created by Rihan on 21/12/22.
//

import XCTest
@testable import WigzoiOSSDK

final class UserProfileMapperTest: XCTestCase {
    
    private var userProfileMapper : UserProfileMapper? = nil

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPositive() throws {
        userProfileMapper = UserProfileMapper()
        userProfileMapper = userProfileMapper!.setEmail(email: "grand@on.com")
        userProfileMapper = userProfileMapper!.setPhone(phone: "9876543210")
        userProfileMapper = userProfileMapper!.setGender(gender: "M")
        userProfileMapper = userProfileMapper!.setOrganization(organization: "ORGANIZATION NAME")
        userProfileMapper = userProfileMapper!.setFullName(fullName: "FULL NAME")
        userProfileMapper = userProfileMapper!.setUserName(userName: "USER_NAME")
        userProfileMapper = userProfileMapper!.setBirthYear(birthYear: "1987")
        
        try! userProfileMapper?.push()
        
    }
    
    func testNegativeNilUserProfile() throws {
        XCTAssertNil(try userProfileMapper?.push())
    }
    
    func testNegativeBlankUserProfile() throws {
        userProfileMapper = UserProfileMapper()
        XCTAssertThrowsError(try userProfileMapper?.push())
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
