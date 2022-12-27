//
//  UserProfileMapper.swift
//  
//
//  Created by Rihan on 06/12/22.
//

import Foundation

public class UserProfileMapper : Task {
    
    private var fullName : String? = nil
    private var userName : String? = nil
    private var email : String? = nil
    private var organization : String? = nil
    private var phone : String? = nil
    private var gender : String? = nil
    private var birthYear : String? = nil
    private var customData : Dictionary<String, Any>? = nil
    
    override public init() {}
    
    public init(fullName : String?, userName : String?, email : String?, organization : String?, phone : String?, gender : String?, birthYear : String?, customData : Dictionary<String, Any>?) {
            self.fullName = fullName
            self.userName = userName
            self.email = email
            self.organization = organization
            self.phone = phone
            self.gender = gender
            self.birthYear = birthYear
            self.customData = customData
    }
    
    public func setFullName(fullName : String) -> UserProfileMapper { self.fullName = fullName; return self }
    public func setUserName(userName : String) -> UserProfileMapper { self.userName = userName; return self }
    public func setEmail(email : String) -> UserProfileMapper { self.email = email; return self }
    public func setOrganization(organization : String) -> UserProfileMapper { self.organization = organization; return self }
    public func setPhone(phone : String) -> UserProfileMapper { self.phone = phone; return self }
    public func setGender(gender : String) -> UserProfileMapper { self.gender = gender; return self }
    public func setBirthYear(birthYear : String) -> UserProfileMapper { self.birthYear = birthYear; return self }
    public func setCustomData(customData : Dictionary<String, Any>) -> UserProfileMapper { self.customData = customData; return self }
    
    public func getFullName() -> String { return self.fullName! }
    public func getUserName() -> String { return self.userName! }
    public func getEmail() -> String { return self.email! }
    public func getOrganization() -> String { return self.organization! }
    public func getPhone() -> String { return self.phone! }
    public func getGender() -> String { return self.gender! }
    public func getBirthYear() -> String { return self.birthYear! }
    public func getCustomData() -> Dictionary<String, Any> { return self.customData! }
    
    override func buildUrl() -> String? {
        return "\(self.getBaseURL())\(Configuration.USER_PROFILE_URL.value())?\(Configuration.SITE_ID.value())=\(Wigzo.getOrgToken() ?? "")"
    }
    
    override func dict() -> Dictionary<String, Any>? {
        var userProfile : Dictionary<String, Any> = [:]
        
        if StringUtils.isNotEmpty(self.fullName) {
            userProfile["fullName"] = self.fullName
        }
        if StringUtils.isNotEmpty(self.userName) {
            userProfile["userName"] = self.userName
        }
        if StringUtils.isNotEmpty(self.email) {
            userProfile["email"] = self.email
        }
        if StringUtils.isNotEmpty(self.organization) {
            userProfile["organization"] = self.organization
        }
        if StringUtils.isNotEmpty(self.phone) {
            userProfile["phone"] = self.phone
        }
        if StringUtils.isNotEmpty(self.gender) {
            userProfile["gender"] = self.gender
        }
        if StringUtils.isNotEmpty(self.birthYear) {
            userProfile["birthYear"] = self.birthYear
        }
        if self.customData?.count ?? 0 > 0 {
            userProfile["customData"] = self.customData
        }
        return userProfile
    }
    
    override internal func validate() throws -> Bool {
        if StringUtils.allEmpty(self.fullName, self.userName, self.email, self.organization, self.phone, self.gender, self.birthYear) && self.customData?.count ?? 0 <= 0 {
            throw Validation.UserProfileMapperError("User profile should contain at least one field: fullName (String), userName (String), email (String), organization (String), phone (String), gender (String), birthYear (String) or customData(Dictionary)");
        }
        return true;
    }
    
}
