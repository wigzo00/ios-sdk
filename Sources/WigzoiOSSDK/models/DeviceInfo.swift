//
//  DeviceInfo.swift
//  
//
//  Created by Rihan on 25/11/22.
//

import Foundation
import UIKit

public class DeviceInfo : Model {
    
    private var device : String? = nil
    private var os : String? = nil
    private var osVersion : String? = nil
    private var ipAddress : String? = nil
    private var appVersion : String? = nil
    private var location : Location? = nil
    
    public init() {
        self.device = UIDevice.current.name
        self.os = "iOS"
        self.osVersion = UIDevice.current.systemVersion
        self.ipAddress = ""
        self.appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        self.location = nil
    }
    
    public func setDevice(device : String) -> DeviceInfo {
        self.device = device
        return self
    }
    public func setOs(os : String) -> DeviceInfo {
        self.os = os
        return self
    }
    public func setOsVersion(osVersion : String) -> DeviceInfo {
        self.osVersion = osVersion
        return self
    }
    public func setIpAddress(ipAddress : String) -> DeviceInfo {
        self.ipAddress = ipAddress
        return self
    }
    public func setAppVersion(appVersion : String) -> DeviceInfo {
        self.appVersion = appVersion
        return self
    }
    public func setLocation(location : Location) -> DeviceInfo {
        self.location = location
        return self
    }
    
    public func getDevice() -> String? {
        return self.device
    }
    public func getOs() -> String? {
        return self.os
    }
    public func getOsVersion() -> String? {
        return self.osVersion
    }
    public func getIpAddress() -> String? {
        return self.ipAddress
    }
    public func getAppVersion() -> String? {
        return self.appVersion
    }
    public func getLocation() -> Location? {
        return self.location
    }
    
    public func dict() -> Dictionary<String, Any> {
        var deviceInfo : Dictionary<String, Any> = [:]
        if let device = self.device {
            deviceInfo["device"] = device
        }
        if let os = self.os {
            deviceInfo["os"] = os
        }
        if let osVersion = self.osVersion {
            deviceInfo["osVersion"] = osVersion
        }
        if let ipAddress = self.ipAddress {
            deviceInfo["ipAddress"] = ipAddress
        }
        if let appVersion = self.appVersion {
            deviceInfo["appVersion"] = appVersion
        }
        
        let location = self.location?.dict()
        if location?.count ?? 0 > 0 {
            deviceInfo["location"] = location
        }
        return deviceInfo
    }
    
    func isValid() throws -> Bool {        
        guard !(StringUtils.allEmpty(self.device, self.os, self.osVersion, self.ipAddress, self.appVersion)) else {
            throw Validation.DeviceInfoError("Device info should contain at least: device (String), os (String), osVersion (String), ipAddress (String), appVersion (String), or location (Location)")
        }
        return true;
    }
}
