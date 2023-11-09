//
//  NotificationRecieved.swift
//  
//
//  Created by Rihan on 10/01/23.
//

import Foundation

public class NotificationRecieved : WigzoNotification {
    
    override public init(){}
    
    public init(campaignId : Int, organizationId : Int) {
        super.init()
        self.campaignId = campaignId
        self.organizationId = organizationId
    }
    
    override func buildUrl() -> String {
        return "\(Configuration.BASE_URL.value())\(Configuration.FCM_READ_URL.value())?\(Configuration.SITE_ID.value())=\(Wigzo.getOrgToken() ?? "")"
    }
}
