//
//  Location.swift
//  
//
//  Created by Rihan on 25/11/22.
//

import Foundation

public class Location : Model {
    private var countryCode : String? = nil
    private var stateName : String? = nil
    private var stateCode : String? = nil
    private var city : String? = nil
    
    public func setCountryCode(countryCode : String) -> Void {
        self.countryCode = countryCode
    }
    public func setStateName(stateName : String) -> Void {
        self.stateName = stateName
    }
    public func setStateCode(stateCode : String) -> Void {
        self.stateCode = stateCode
    }
    public func setCity(city : String) -> Void {
        self.city = city
    }
    
    public func getCountryCode() -> String { return self.countryCode! }
    public func getStateName() -> String { return self.stateName! }
    public func getStateCode() -> String { return self.stateCode! }
    public func getCity() -> String { return self.city! }
    
    func dict() -> Dictionary<String, Any> {
        var locationData : Dictionary<String, String> = [:]
        if let countryCode = self.countryCode{
            locationData["countryCode"] = countryCode
        }
        if let stateName = self.stateName{
            locationData["stateName"] = stateName
        }
        if let stateCode = self.stateCode{
            locationData["stateCode"] = stateCode
        }
        if let city = self.city{
            locationData["city"] = city
        }
        return locationData
    }
    
    func isValid() throws -> Bool {
        let location : Location? = self
        guard location != nil && (location?.city != nil || location?.countryCode != nil || location?.stateCode != nil || location?.stateName != nil) else {
            throw Validation.LocationError("Location should contain at least one field: countryCode (String), stateName (String), stateCode (String), city (String)")
        }
        return true;
    }
}
