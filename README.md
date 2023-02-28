# WigzoiOSSDK

A description of this package.

#Integration

**This article will guide you through the process of iOS Android SDK integration.**
**You can integrate WigzoiOSSDK in your app in simple steps.**

#Initializing Wigzo SDK
**To initialize Wigzo iOS SDK we have provided 2 functions, initialize(orgToken : String) and initialize(orgToken:forceInit)**

**initialize(orgToken:) :** This function is used to initialize the SDK without perfoming any other task. This is the simplest way to initialize the SDK.

**initialize(orgToken:forceInit) :** This function is used to reinitialize the Wigzo iOS SDK. This is used in the scenerio when the user logs out in your application and you want to register the device with a new user or anonymous user.

- Create a UIApplicationDelegate
- In the application(_:didFinishLaunchingWithOptions:) delegate Initialize the Wigzo iOS SDK

######example:
```swiift

import SwiftUI

struct YourApp : App {
    @UIApplicationDelegatAdaptor(AppDelegate.self) var appDelegate
    
    var body : some Scene {
        // Your Code goes here
    }
}

class AppDelegate : NSObject, UIApplicationDelegate {
    func application(_ application : UIApplication, didFinishLaunchingWithOptions launchOptions : [UIApplication.LaunchOptions : Any]? = nil) -> Bool {
        Wigzo.initialize(orgToken: "<YOUR_ORGANIZATION_TOKEN>")
        return true
    }
}

```

Congratulations! You have successfully integrated Wigzo SDK in your app. Let us guide you through usage of this SDK.

#Using Wigzo iOS SDK

###Setting up Events (or Activity) tracking.

Below API's capture event occurred for a user. You can use these API's whenever an event or activity occurs.

####EventMapper
**To create event with only event name and value:**
>Create instance of EventMapper.
>Create an instance of EventData.
>Set eventName <String> and eventValue <String>.
>Add EventData instance to EventMapper.

####EventData
**EventData includes the following information:**

| fields | Description |
|:---------------------|:----------------------------------------------|
| eventName | name of the event |
| eventValue | value of the event |
| eventMetaData | additional information about event |

####Metadata
**To create event with additional event information :**
> 1. Create instance of EventMetaData.
> 2. Set this instance in EventData instance

**Metadata includes information :**

| fields | Description |
|:------------|:--------------------------|
| productId   | Product Id of Item |
| title | Title of item |
| description | Description of item |
| url | Web or android url of Item |
| tags | Tags related to item |
| price | Price of Item |

####DeviceInfo
***To create event with device information :***
> 1. To add DeviceInfo, create instance of DeviceInfo.
> 2. Set this instance in EventMapper instance.

**DeviceInfo includes information :**

| fields | Description |
|:--------------|:--------------------------|
| device | Build of the device |
| os | Android |
| osVersion | version of OS |
| ipAddress | IP address of the device |
| appVersion | Your app version |
| location | Location of the device |

> By default, device, os, osVersion and appVersion is prefilled. However, you still can set your own values by using their respective setters.

####Location
**To add location in DeviceInfo :**
> 1. Create an instance of Location
> 2. Set it to DeviceInfo instance.

**Location includes information:**

| fields        | Description |
|:--------------|:----------------------------------------------|
| countryCode | Country code |
| stateName | name of the state in which Device is located |
| stateCode | code of the state in which Device is located |
| city | name of the city in which Device is located |

>NOTE: Event name and Event value both are required to create an event.

Example:
```swift
// Required:
        var eventData : EventData = EventData()
        eventData.setEventName("<EVENT_NAME>")
        eventData.setEventValue("<EVENT_VALUE>")

// OPTIONAL:
        var eventMetaData : EventMetaData = EventMetaData()
        eventMetaData.setProductId("<ProductId>")
        eventMetaData.setPrice("40")
        eventMetaData.setDescription("Product description")
        eventMetaData.setTitle("Product Name/Title")
        eventMetaData.setUrl("https://yourwebsite.com/path/to/the/product")
        eventData.setMetadata(eventMetaData)

// OPTIONAL:
        var location : Location = Location()
        location.setCountryCode("Country code")
        location.setStateName("Name of state")
        location.setStateCode("State code")
        location.setCity("Name of the city")

// OPTIONAL:
        var deviceInfo : DeviceInfo = DeviceInfo()
        deviceInfo.setDevice("Device name")
        deviceInfo.setOs("Device OS")
        deviceInfo.setOsVersion("OS VERSION")
        deviceInfo.setIpAddress("Device IP Address")
        deviceInfo.setAppVersion("Your App Version")
        deviceInfo.setLocation(location)

        var eventMapper : EventMapper = EventMapper()
        eventMapper.addEventData(eventData)
        eventMapper.setDeviceInfo(deviceInfo)
        try! eventMapper.push()
```

---
###Setting up User Profile tracking.
Below API's help you capture profile of User. User’s profile should be created only once.
####UserProfileMapper
> Wigzo has provided a class “UserProfileMapper” which can be used to capture user's profile.

**To create User profile:**
> 1. Create an instance of UserProfileMapper.

**UserProfileMapper ​class includes following fields :**

|  Fields | Description |
|:----------------|:---------------------------------|
| fullName | Full name of user |
| userName | User name of user |
| email | Email of user |
| organization | Organization of the user |
| phone | Phone number of user |
| gender | Gender of user |
| birthYear | Birth year of user |
| customData | Json to provide any other data about user |

> 1. Overloaded Constructors of this class can be called as mentioned below:
> 2. Setters are  also provided for other fields.

**To save and send User profile data to Wigzo , following method can be used :**
> `try! <userProfile_instance>.push()`

######example:
```swiift
var userProfileMapper : UserProfileMapper()
userProfileMapper = userProfileMapper!.setEmail(email: "<USER_EMAIL>")
userProfileMapper = userProfileMapper!.setPhone(phone: "<USERPHONE>")
userProfileMapper = userProfileMapper!.setGender(gender: "<GENDER>")
userProfileMapper = userProfileMapper!.setOrganization(organization: "<ORGANIZATION_NAME_OF_USER>")
userProfileMapper = userProfileMapper!.setFullName(fullName: "<USER_FULL_NAME>")
userProfileMapper = userProfileMapper!.setUserName(userName: "<USERNAME>")
userProfileMapper = userProfileMapper!.setBirthYear(birthYear: "<BIRTH_YEAR_OF_USER>")

try! userProfileMapper?.push()

```

####Exceptional Case :
####EmailMapper
> When User profile information is not there but only email of user is there,
in such a cases, create an instance of EmailMapper class.

```swift
var userEmailMapper : UserEmailMapper = UserEmailMapper(<email>)
      try! userEmailMapper.push()
```

> Setter is also provided to set email explicitly.

>***Note***: Please note that in this case user profile is not getting created and only email id is stored for tracking purposes.

###FIREBASE

#####To integrate Firebase in your App [Click here](https://firebase.google.com/docs/cloud-messaging)

There are few events which are required to be sent to Wigzo in order to show you the correct information about the campaigns triggered from Wigzo Dashboard.

First you need to map FCM token with Wigzo and then register the token.

####Map FCM
To map FCM with Wigzo, create an instance of FCMMapper class with the FCM token and push it. Wigzo is required to be notiofied about the token every time the token is generated.

####Register FCM
To Register FCM with Wigzo, create an instance of FCMRegister class with the FCM token and push it. This step also is mandatory whenever a new token is generated.

>***Note***: Map FCM and Register FCM both are required when a new token is generated. Also Map FCM should happen before registering.

Example:
In your FCM Listener service
```swift

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")

        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
        
        sendRegistrationToServer(fcmToken)
    }
    
    private func sendRegistrationToServer(token : String) -> Void {
        // TODO: Implement this method to send token to your app server.
        var fcmMapper : FCMMapper = FCMMapper(token)
        fcmMapper.push()

        var fcmRegister : FCMRegister = FCMRegister(token)
        fcmRegister.push()
    }
```

####Notifying Wigzo about the notification received:
Notifying Wigzo that the notification has been recieived by the user is important, as it helps us keep track of the data which has been sent by Wigzo to provide you with the important insights about your campaigns. To do so:

- In the `onMessageReceived()` method in your FCM Listener class, crate an instance of NotificationRecieved class. It requires Organization ID and Campaign ID which came along the notification, sent via Wigzo dashboard.
  Example:
```swift
// [START ios_10_message_handling]
extension AppDelegate: UNUserNotificationCenterDelegate {
  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification) async
    -> UNNotificationPresentationOptions {
    let userInfo = notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)
    // [START_EXCLUDE]
    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }
    // [END_EXCLUDE]
    // Print full message.
    print(userInfo)
    
    // Notify Wigzo about notification received.
    var notificationRecieved NotificationRecieved = NotificationRecieved(<ORGANIZATION_ID>, <CAMPAIGN_ID>);
    notificationRecieved.push();
    // Organnizaiton ID and Campaign ID can be fetched from the notification data.

    // Change this to your preferred presentation option
    return [[.alert, .sound]]
  }
}

// [END ios_10_message_handling]
```

####Notifying Wigzo about the notification Clicked:
Notifying Wigzo about the notification has been clicked by the user is another crucial step as it helps Wigzo collecting the data about the campaigns triggered from the Wigzo Dashboard. To do so:
Create an instance of NotificationOpen class and pass the fetched `campaignId` as well as the `organizationId`, and push the instance in the queue.

Example:

```swift
// [START ios_10_message_handling]
extension AppDelegate: UNUserNotificationCenterDelegate {

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse) async {
    let userInfo = response.notification.request.content.userInfo

    // [START_EXCLUDE]
    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }
    // [END_EXCLUDE]
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)
    // Print full message.
    print(userInfo)
    
    var notificationOpen : NotificationOpen = NotificationOpen(<ORGANIZATION_ID>, <CAMPAIGN_ID>);
    notificationOpen.push();
  }
}

// [END ios_10_message_handling]
```

>The above code will create the Notification with the `campaignId` and the `organizationId` packed within the notificaiton.
