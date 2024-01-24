// created by Shivam Ratnam

import Foundation
import UserNotifications
public class Wigzo {
    
    public static func getStringFromStorage(forKey: String) -> String? {
        
        return UserDefaults().string(forKey: forKey)
    }
    
    public static func setToStorage(value: String, forKey: String) -> Void {
        return UserDefaults().set(value, forKey: forKey)
    }
    
    public static func getOrgToken() -> String? {
        return getStringFromStorage(forKey: Configuration.ORG_TOKEN_KEY.key())
    }
    
    public static func getOrCreateDeviceId() -> String {
        var deviceId : String? = getStringFromStorage(forKey: Configuration.DEVICE_ID_KEY.value())
        if deviceId == nil {
            deviceId = UUID().uuidString
            setToStorage(value: deviceId!, forKey: Configuration.DEVICE_ID_KEY.value())
        }
        return deviceId!
    }
    
    public static func getOrCreateAppKey() -> String {
        var appKey : String? = getStringFromStorage(forKey: Configuration.APP_KEY.value())
        if appKey == nil {
            appKey = UUID().uuidString
            setToStorage(value: appKey!, forKey: Configuration.APP_KEY.value())
        }
        return appKey!
    }
    
    private static func setOrgToken(_ token: String) -> Void {
        setToStorage(value: token, forKey: Configuration.ORG_TOKEN_KEY.key())
    }
    
    public static func initialize(orgToken: String) throws -> Void {
        guard StringUtils.isNotEmpty(orgToken) else {
            throw Validation.InitializaitionError("Organization Token not provided. Visit Wigzo settings in the Wigzo dashboard to get your organization token")
        }
        setOrgToken(orgToken)
        setDeviceMappingTask()
    }
    
    public static func initialize(orgToken: String, forceInit : Bool) throws -> Void {
        guard StringUtils.isNotEmpty(orgToken) else {
            throw Validation.InitializaitionError("Organization Token not provided. Visit Wigzo settings in the Wigzo dashboard to get your organization token")
        }
        setOrgToken(orgToken)
        setDeviceMappingTask()
    }
    
    public static func setDeviceMappingTask() -> Void {
        try! DeviceMapper().push()
    }
    public static func setPushNotifiaction(_ userInfo: UNNotification) -> Void {
        guard let userInfo = userInfo.request.content.userInfo as? [String: Any] else { return }
        
        showPushNotification(userInfo)
    }
    
//    private static func showPushNotification(_ userInfo: [String: Any]) {
//        if #available(iOS 13.0, *) {
//            guard let jsonData = try? JSONSerialization.data(withJSONObject: userInfo, options: []) else { return }
//            let payloadData: WigzoNotification1 = try! JSONDecoder().decode(WigzoNotification1.self, from: jsonData)
//            let helper = HelperClass()
//            helper.showInAppNotificationViewController(payloadJson: payloadData)
//        }
//        
//    }
    // Modify the showPushNotification method in your Wigzo class
    private static func convertStringToDictionary(text: String) -> [String: Any]? {
            if let data = text.data(using: .utf8) {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                    return json
                } catch {
                    print("Something went wrong while converting string to dictionary: \(error)")
                }
            }
            return nil
        }

    private static func showPushNotification(_ userInfo: [String: Any]) {
        guard let typeDictString = userInfo["type"] as? String,
              let pushType = convertStringToDictionary(text: typeDictString),
              let pushTypeValue = pushType["pushType"] as? String else {
            // Handle the case where pushType is not present or not a string
            return
        }

        if pushTypeValue == "inApp" {
            // Handle in-app notification
            if #available(iOS 13.0, *) {
                guard let jsonData = try? JSONSerialization.data(withJSONObject: userInfo, options: []) else { return }
                let payloadData: WigzoNotification1 = try! JSONDecoder().decode(WigzoNotification1.self, from: jsonData)
                let helper = HelperClass()
                helper.showInAppNotificationViewController(payloadJson: payloadData)
            }
        } else if pushTypeValue == "push" {
            // Handle push notification
            // You can add your push notification handling logic here
            // For example, you can display a banner or customize the notification UI
        } else {
            // Handle other cases if needed
            // You might want to log or ignore notifications with unknown pushType values
        }
    }
    

}
