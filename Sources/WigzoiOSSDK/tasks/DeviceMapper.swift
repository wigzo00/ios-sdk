//
//  DeviceMapper.swift
//  
//
//  Created by Rihan on 18/11/22.
//

import Foundation

public class DeviceMapper : Task {
    
    override func buildUrl() -> String? {
        return "\(self.getBaseURL())\(Configuration.INITIAL_DATA_URL.value())?\(Configuration.SITE_ID.value())=\(Wigzo.getOrgToken() ?? "")"
        
    }
    
    override func dict() -> Dictionary<String, Any>? {
        var data : Dictionary<String, Any> = [:]
        let deviceInfo = DeviceInfo()
        do {
            if try deviceInfo.isValid() {
                data["deviceInfo"] = deviceInfo.dict()
            }
        } catch let error {
            print(error.self)
        }
        return data
    }
    
    override internal func validate() -> Bool {
        return true;
    }
}
