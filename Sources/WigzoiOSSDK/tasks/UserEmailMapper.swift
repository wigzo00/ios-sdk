//
//  UserEmailMapper.swift
//  
//
//  Created by Rihan on 06/12/22.
//

import Foundation

public class UserEmailMapper : Task {
    
    private var email : String? = nil
    
    override public init(){}
    
    public init(email : String) {
        self.email = email
    }
    
    public func setEmail(email : String) -> UserEmailMapper {
        self.email = email
        return self
    }
    
    public func getEmail() -> String {
        return self.email!
    }
    
    override func buildUrl() -> String? {
        return "\(self.getBaseURL())\(Configuration.EMAIL_DATA_URL.value())?\(Configuration.SITE_ID.value())=\(Wigzo.getOrgToken() ?? "")"
    }
    
    override func dict() -> Dictionary<String, Any>? {
        var userEmailMapper : Dictionary<String, Any> = [:]
        if StringUtils.isNoneEmpty(self.email) {
            userEmailMapper["email"] = self.email
        }
        return userEmailMapper
    }
    
    override internal func validate() throws -> Bool {
        if StringUtils.isEmpty(self.email) {
            throw Validation.UserEmailMapperError("Email cannot be blank")
        }
        return true
    }
}
