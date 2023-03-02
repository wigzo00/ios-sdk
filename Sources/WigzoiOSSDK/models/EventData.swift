//
//  EventData.swift
//  
//
//  Created by Rihan on 02/12/22.
//

import Foundation

public class EventData : Model {
    private var eventName : String?
    private var eventValue : String?
    private var metadata : EventMetaData?
    
    public init() {}
    
    public init (eventName : String, eventValue : String, metadata : EventMetaData?) {
        self.eventName = eventName
        self.eventValue = eventValue
        self.metadata = metadata!
    }
    
    public func setEventName(eventName : String) -> EventData { self.eventName = eventName; return self }
    public func setEventValue(eventValue : String) -> EventData { self.eventValue = eventValue; return self }
    public func setMetadata(metadata : EventMetaData) -> EventData { self.metadata = metadata; return self }
    
    public func getEventName() -> String { return self.eventName! }
    public func getEventValue() -> String { return self.eventValue! }
    public func getMetadata() -> EventMetaData { return self.metadata! }
    
    func dict() -> Dictionary<String, Any> {
        var eventData : Dictionary<String, Any> = [:]
        if StringUtils.isNotEmpty(self.eventName) {
            eventData["eventName"] = self.eventName
        }
        if StringUtils.isNotEmpty(self.eventValue) {
            eventData["eventValue"] = self.eventValue
        }
        let metadata = self.metadata != nil ? self.metadata?.dict() : [:]
        if metadata?.count ?? 0 > 0 {
            eventData["metadata"] = metadata
        }
        return eventData;
    }
    
    func isValid() throws -> Bool {
        if !StringUtils.isNoneEmpty(self.eventName, self.eventValue) {
            throw Validation.EventDataError("Event name and Event Value both are required to send an event.")
        }
        return true;
    }
}
