//
//  WigzoNotification.swift
//  
//
//  Created by Rihan on 10/01/23.
//

import Foundation

public class WigzoNotification : Task {
    internal var uuid : String? = nil
    internal var campaignId : Int? = 0
    internal var organizationId : Int? = 0
    internal var timestamp : String? = nil
    
    internal var url : String = ""
    
    public func setCampaignId(campaignId : Int) -> Void {
        self.campaignId = campaignId
    }
    
    public func getCampaignId() -> Int? {
        return self.campaignId
    }
    
    
    public func setOrganizationId(organizationId : Int) -> Void {
        self.organizationId = organizationId
    }
    
    public func getOrganizationId() -> Int? {
        return self.organizationId
    }
    
    override func buildUrl() -> String {
        return self.url
    }
    
    override public func dict() -> Dictionary<String, Any>? {
        var data : Dictionary<String, Any> = [:]
        if self.campaignId! > 0 {
            data["campaignId"] = self.campaignId
        }
        if self.organizationId! > 0 {
            data["organizationId"] = self.organizationId
        }
        return data
    }
    
    override internal func validate() throws -> Bool {
        if self.campaignId! < 1 && self.organizationId! < 1 {
            throw Validation.NotificationError("Campaign and Organization ID cannot be less than or equal to 0")
        }
        return true;
    }
}
