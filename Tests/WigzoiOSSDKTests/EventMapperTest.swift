//
//  EventMapperTest.swift
//  
//
//  Created by Rihan on 21/12/22.
//

import XCTest
@testable import WigzoiOSSDK

final class EventMapperTest: XCTestCase {
    
    private static var EVENT_NAME = "test"
    private static var EVENT_VALUE = "tested"
    
    private var eventMapper : EventMapper? = nil
    private var eventData : EventData? = nil
    private var metaData : EventMetaData? = nil
    private var location : Location? = nil
    private var deviceInfo : DeviceInfo? = nil
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        metaData = EventMetaData()
        metaData!.setProductId(productId : "1")
        metaData!.setPrice(price : 40)
        metaData!.setDescription(description : "Product description")
        metaData!.setTitle(title : "Product Name/Title")
        metaData!.setUrl(url : "https://yourwebsite.com/path/to/the/product")
        
        location = Location()
        location!.setCountryCode(countryCode : "Country code")
        location!.setStateName(stateName : "Name of state")
        location!.setStateCode(stateCode : "State code")
        location!.setCity(city : "Name of the city")
        
        deviceInfo = DeviceInfo()
        deviceInfo!.setDevice(device : "Device name")
        deviceInfo!.setOs(os : "Device OS")
        deviceInfo!.setOsVersion(osVersion : "OS VERSION")
        deviceInfo!.setIpAddress(ipAddress : "Device IP Address")
        deviceInfo!.setAppVersion(appVersion : "Your App Version")
//        deviceInfo = deviceInfo!.setLocation(location : location!)
        
        eventData = EventData()
//        eventData = eventData!.setMetadata(metadata : metaData!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPositive() throws {
                
        eventData = eventData?.setEventName(eventName: EventMapperTest.EVENT_NAME)
        eventData = eventData?.setEventValue(eventValue: EventMapperTest.EVENT_VALUE)
        eventData = eventData?.setMetadata(metadata: metaData!)
        
        deviceInfo?.setLocation(location: location!)
        
        eventMapper = EventMapper()
        
        eventMapper = eventMapper?.setEventData(eventData: eventData!)
        eventMapper = eventMapper?.setDeviceInfo(deviceInfo: deviceInfo!)
        
        XCTAssertThrowsError(try! eventMapper?.push())
    }
    
    func testNegativeNilEventMapper() throws {
        XCTAssertNil(try eventMapper?.push())
    }
    
    func testNegativeNilEventdata() throws {
        eventMapper = EventMapper()
        XCTAssertThrowsError(try eventMapper?.push())
    }
    
    func testNegativeBlankEventData() throws {
        eventMapper = EventMapper()
        eventMapper = eventMapper?.setEventData(eventData: eventData!)
        XCTAssertThrowsError(try eventMapper?.push())
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
