//
//  EventMapper.swift
//  
//
//  Created by Rihan on 25/11/22.
//

import Foundation

public class EventMapper : Task {
    
    private var eventData : EventData? = nil
    private var deviceInfo : DeviceInfo? = DeviceInfo()
    
    override public init() {}
    
    public init(eventData : EventData, deviceInfo : DeviceInfo) {
        self.eventData = eventData
        self.deviceInfo = deviceInfo
    }
    
    public func setEventData(eventData : EventData) -> EventMapper {
        self.eventData = eventData
        return self
    }
    
    public func setDeviceInfo(deviceInfo : DeviceInfo) -> EventMapper {
        self.deviceInfo = deviceInfo
        return self
    }
    
    public func getEventData() -> EventData? {
        return self.eventData!
    }
    
    public func getDeviceInfo() -> DeviceInfo? {
        return self.deviceInfo!
    }
    
    override func buildUrl() -> String? {
        return "\(Configuration.BASE_URL.value())\(Configuration.EVENT_DATA_URL.value())?\(Configuration.SITE_ID.value())=\(Wigzo.getOrgToken() ?? "")"
    }
    
    override func dict() -> Dictionary<String, Any>? {
        var event : Dictionary<String, Any> = [:]
        event["deviceInfo"] = self.deviceInfo?.dict() ?? [:]
        event["eventData"] = [self.eventData?.dict() ?? [:]]
        return event;
    }
    
    override internal func validate() throws -> Bool {
        do {
            let isValid = try self.eventData?.isValid()
            if isValid == nil || !isValid! {
                throw Validation.EventMapperError("Not valid Event Data provided. It is probably nil")
            }
            return true
        } catch let error {
            print(error)
            throw error
        }
    }
}
