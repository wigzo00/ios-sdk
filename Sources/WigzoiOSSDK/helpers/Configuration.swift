//
//  Configuration.swift
//
//
//  Created by Rihan on 17/11/22.
//

import Foundation

public enum Configuration {
    
    case BASE_URL, APP_KEY, DEFAULT_APP_VERSION, DEFAULT_SDK_VERSION, DEVICE_ID_KEY, DEVICE_ID_TAG, DEVICE_LOCATION_KEY, EMAIL_DATA_URL, EMAIL_KEY, EMAIL_SYNC_KEY, EVENTS_KEY, EVENT_DATA_URL, FCM_DEVICE_MAPPED, FCM_DEVICE_MAPPING_URL, FCM_OPEN_KEY, FCM_OPEN_URL, FCM_READ_KEY, FCM_READ_URL, FCM_REGISTRATION_URL, FCM_TOKEN, INITIAL_DATA_URL, ORG_TOKEN_KEY, PREV_TIME_SPENT_KEY, SENT_FCM_TOKEN_TO_SERVER, SESSION_DATA_URL, SITE_ID, STORAGE_KEY, TIME_DELAY, TIME_SPENT_KEY, USER_PROFILE_DATA_KEY, USER_PROFILE_PICTURE_KEY, USER_PROFILE_SYNC_KEY, USER_LOCATION_URL, USER_PROFILE_URL, WIGZO_FCM_LISTENER_SERVICE_TAG, WIGZO_INIT_DATA_SYNC_FLAG_KEY, WIGZO_REG_INTENT_SERVICE_TAG, WIGZO_SDK_TAG, APP_RUNNING_STATUS
    
    var get: (key: String, value: String) {
        switch self {
        case .BASE_URL:
     // return ("baseUrl", "http://10.10.11.242:9000")
            
            return ("baseUrl", "https://app-stage.wigzo.tech")
           // return ("baseUrl", "http://192.168.4.83:9000")
      
       // return ("baseUrl", "https://app.wigzo.com")
       // return ("baseUrl","https://app.wigzo.com")
        case .APP_KEY:
            return ("appKey", "APP_KEY")
        case .DEFAULT_APP_VERSION:
            return ("defaultAppVersion", "1.0")
        case .DEFAULT_SDK_VERSION:
            return ("defaultSdkVersion", "1.0")
        case .DEVICE_ID_KEY:
            return ("deviceIdKey", "DEVICE_ID_KEY")
        case .DEVICE_ID_TAG:
            return ("deviceIdTag", "DeviceInfo")
        case .DEVICE_LOCATION_KEY:
            return ("deviceLocationKey", "DEVICE_LOCATION_KEY")
        case .EMAIL_DATA_URL:
            return ("emailDataUrl", "/androidsdk/mapemail")
        case .EMAIL_KEY:
            return ("emailKey", "EMAIL_KEY")
        case .EMAIL_SYNC_KEY:
            return ("emailSyncKey", "EMAIL_SYNC_KEY")
        case .EVENTS_KEY:
            return ("eventKey", "WIGZO_EVENTS")
        case .EVENT_DATA_URL:
            return ("eventDataUrl", "/androidsdk/geteventdata")
        case .FCM_DEVICE_MAPPED:
            return ("fcmDeviceMapped", "FCM_DEVICE_MAPPED")
        case .FCM_DEVICE_MAPPING_URL:
            return ("fcmDeviceMappingUrl", "/androidsdk/map-fcm")
        case .FCM_OPEN_KEY:
            return ("fcmOpenKey", "FCM_OPEN_KEY")
        case .FCM_OPEN_URL:
            return ("fcmOpenUrl", "/rest/v1/push/android/track/open-multiple")
        case .FCM_READ_KEY:
            return ("fcmReadKey", "FCM_READ_KEY")
        case .FCM_READ_URL:
            return ("fcmReadUrl", "/rest/v1/push/android/track/read-multiple")
        case .FCM_REGISTRATION_URL:
            return ("fcmRegistrationUrl", "/rest/v1/push/android/register-subscription")
        case .FCM_TOKEN:
            return ("fcmToken", "FCM_TOKEN")
        case .USER_LOCATION_URL:
            return ("userLocationUrl", "/report/track/web")
        case .INITIAL_DATA_URL:
            return ("initialDataUrl", "/androidsdk/getinitialdata")
        case .ORG_TOKEN_KEY:
            return ("orgToken", "ORG_TOKEN_KEY")
        case .PREV_TIME_SPENT_KEY:
            return ("prevTimeSpent", "PREV_TIME_SPENT_KEY")
        case .SENT_FCM_TOKEN_TO_SERVER:
            return ("sentTokenToServer", "SENT_FCM_TOKEN_TO_SERVER")
        case .SESSION_DATA_URL:
            return ("sessionDataUrl", "/androidsdk/getsessiondata")
        case .SITE_ID:
            return ("siteid", "_siteid")
        case .STORAGE_KEY:
            return ("storageKey", "WIGZO_SHARED_STORAGE")
        case .TIME_DELAY:
            return ("timeDelay", "45")
        case .TIME_SPENT_KEY:
            return ("timeSpentKey", "TIME_SPENT_KEY")
        case .USER_PROFILE_DATA_KEY:
            return ("userProfileDataKey", "USER_PROFILE_DATA_KEY")
        case .USER_PROFILE_PICTURE_KEY:
            return ("userProfilePictureKey", "USER_PROFILE_PICTURE_KEY")
        case .USER_PROFILE_SYNC_KEY:
            return ("userProfileSyncKey", "USER_PROFILE_SYNC_KEY")
        case .USER_PROFILE_URL:
            return ("userProfileUrl", "/androidsdk/getuserprofiledata")
        case .WIGZO_FCM_LISTENER_SERVICE_TAG:
            return ("wigzoFCMListenerServiceTag", "WigzoFcmListenerService")
        case .WIGZO_INIT_DATA_SYNC_FLAG_KEY:
            return ("wigzoInitiDataSyncFlag", "WIGZO_INIT_DATA_SYNC_FLAG_KEY")
        case .WIGZO_REG_INTENT_SERVICE_TAG:
            return ("wigzoRegIntentServiceTag", "RegIntentService")
        case .WIGZO_SDK_TAG:
            return ("wigzoSdkTag", "Wigzo")
        case .APP_RUNNING_STATUS:
            return ("appRunningSatus", "AppRunningStatus")
        }
    }
    
    func key() -> String {
        return self.get.key
    }
    
    func value() -> String {
        return self.get.value
    }
}

internal enum Validation : Error {
    case InitializaitionError(String)
    case LocationError(String)
    case DeviceInfoError(String)
    case EventMapperError(String)
    case EventDataError(String)
    case EventMetaDataError(String)
    case UserEmailMapperError(String)
    case UserProfileMapperError(String)
    case FCMMapperError(String)
    case FCMRegisterError(String)
    case NotificationError(String)
}
