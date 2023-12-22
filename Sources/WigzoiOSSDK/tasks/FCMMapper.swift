//
//  FCMMapper.swift
//  
//
//  Created by Rihan on 10/01/23.
//

import Foundation

public class FCMMapper : Task {
    
    private var registrationId : String? = nil
    
    override public init() {}
    
    public init(registrationId : String) {
        self.registrationId = registrationId
    }
    
    public func setRegistrationId(registrationId : String) -> FCMMapper {
        self.registrationId = registrationId
        return self
    }
    
    public func getRegistrationId() -> String? {
        return self.registrationId
    }
    
    override func buildUrl() -> String? {
        return "\(Configuration.BASE_URL.value())\(Configuration.FCM_DEVICE_MAPPING_URL.value())?\(Configuration.SITE_ID.value())=\(Wigzo.getOrgToken() ?? "")"
    }
    
    override func dict() -> Dictionary<String, Any>? {
        var data : Dictionary<String, Any> = [:]
        let deviceInfo = DeviceInfo()
        if StringUtils.isNotEmpty(self.registrationId) {
            data["registrationId"] = self.registrationId
        }
        do {
            if try deviceInfo.isValid() {
                data["deviceInfo"] = deviceInfo.dict()
            }
        } catch let error {
            print(error.self)
        }
        
        return data
    }
    
    override internal func validate() throws -> Bool {
        if(StringUtils.isEmpty(self.registrationId)) {
            throw Validation.FCMMapperError("Firebase registration ID cannot be blank");
        }
        return true;
    }
}
