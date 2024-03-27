//
//  Task.swift
//  
//
//  Created by Rihan on 18/11/22.
//

import Foundation

public class Task {
    
    func buildUrl() -> String? {
        return nil
    }
    
    func dict() -> Dictionary<String, Any>? {
        return nil
    }
    
    internal func validate() throws -> Bool {
        return true
    }
    
    func prepareData() -> Dictionary<String, Any> {
        var data : Dictionary<String, Any> = self.dict()!
        data["deviceId"] = Wigzo.getOrCreateDeviceId()
        data["appKey"] = Wigzo.getOrCreateAppKey()
        data["orgToken"] = Wigzo.getOrgToken()
        return data
    }
    
    private func takeAction() -> Void {
        if let postUrl = self.buildUrl() {
            let preparedData : Dictionary<String, Any> = prepareData()
            print("prepareData:",preparedData)
            
            print("url",postUrl)
            ConnectionStream().postJson(url: postUrl, data: preparedData, headers: nil) {
                data, urlResponse, error in
                print("received URL", urlResponse?.url)
                print("received data", data)
                print("error",error?.localizedDescription)
            }
        }
    }
    
    public func push() throws -> Void {
        do {
            
            let isValid = try self.validate()
            if isValid {
                WigzoDispatchQueue.execute(executable: takeAction)
            }
        } catch let error {
            print("error in push",error.localizedDescription)
            throw error
        }
    }
    
}
