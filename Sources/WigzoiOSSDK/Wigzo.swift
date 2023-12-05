import Foundation
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
        setToStorage(value: UUID().uuidString, forKey: Configuration.DEVICE_ID_KEY.value())
        setToStorage(value: UUID().uuidString, forKey: Configuration.APP_KEY.value())
        setDeviceMappingTask()
    }
    
    public static func setDeviceMappingTask() -> Void {
        try! DeviceMapper().push()
    }
}
