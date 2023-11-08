//
//  AppDelegate.swift
//  demo_inApp
//
//  Created by Shivam on 08/08/23.
//
import UIKit
import Firebase
import UserNotifications
import FirebaseMessaging
import SwiftUI
import WigzoiOSSDK
import UserNotificationsUI
import Foundation


//@available(iOS 16.0, *)
@main
 struct demo_inApp: App {

     init() {}
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

      var body: some Scene {
        WindowGroup {
            ContentView()
        }

    }
}

//@available(iOS 16.0, *)
//@UIApplicationMain
 class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate{
    let helper = HelperClass()
 
     let notificationJson = """
{
  "notification": {
    "mutable-content": 1,
    "title": "Title goes here"
  },
  "data": {
     "type": {
     "type":"Text Only",
     "pushType":"inApp"
     },
    "id": 1280,
    "title": "Title goes here",
    "notificationId": 0,
    "imageUrl": [
      "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg"
    ],
    "secondSound": 0,
    "intentData": "null",
    "uuid": "3e471196-3111-4684-8cd3-81f6fef3ffa2",
    "organizationId": 2,
    "layoutId": "001",
    "isWigzoNotification": true,
    "button": [{
       "buttonUrl":"","buttonName":"Button","buttonAction":"","buttonFontColor":"","buttonFontSize":"14px","buttonColor":""

      }],
    "notification_details": {
      "buttonOrientation": "horizontal",
      "templateOrientation": "top",
      "templateBackground": "#fff",
      "titleColor": "#000",
      "titleFontSize": "14px",
      "descriptionFontSize": "12px",
      "descriptionFontColor": "#060101",
      "isclose": "true",
      "imageOrientation": "fullLayout",
      "textAllignment": "center"
    }
  },
  "apns": {
    "fcm_options": {
      "image": [\"https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg\"]
    },
    "payload": {
      "aps": {
        "alert": {
          "mutable-content": 1,
          "title": "Title goes here"
        },
        "mutable-content": true
      }
    }
  },
  "registration_ids": [
    "eofevrHIQ3W85-041FQoFO:APA91bEKYllb99fARrc_fv3ynXlb1lp64OG37RhCyiVnXn6YGM6vPHvFg51tOPy5ZPJsXUWqY_WNHmU1uAs9PFXXy_nyLZOOip5IhCew3wBAYjQ3tcmG8ayuHkijkx4wC8XRgjA9jjnX",
    "dzuL7Z9jSkyZMnLAk35M3n:APA91bFvmaTYUGtc6KXd8OrH_NZQj2cDrTxh-ZthXPaH_8rwpotNgD-3FjFbwmJXPcF0C65-TL-YmclUd76qHwGKdwxFzVtrcjCA747v772IL7akW7jOK3Yh_CPCdS1YN8liISVGRuTg",
    "fw3plTNMk0ewo573Q2-VD3:APA91bE399tNB03sH0vHQy2gzA6sF869DwSWQfylId2meeFehI3CyT2Zhv6VCSFQ4VR30_3ZWvnogGFnhwq1_yuNcJ8nouDJXHaBFBRZOQtJ8MYgTiSuhbmQ3rHw-ujSj3yQ0ZEIFDaQ",
    "cW4odRtCr06AvU_oPQzX-z:APA91bGHjMz0k10dmENs2068ETfHNKbSXKiZ72LgJN9qROjy9ZUFE0Fy4Lx432-dBuwTZx2zwQdjlCrFbxWZCzbmKlTUgZh59qJ7r-MlJARsGEMLVrOOmQDeO35EHwNl22OenIPQp1La",
    "fPm2vToHTjWCPWY9ZQulX0:APA91bEOZ25woJpKxb22jheZzaXVtdUTiPud8XvuVwX6-yeTONL7-JTm0ZXeBY9WhbHUpztM5_9WqHey26-0cyeWQShK1bGgYJRh9tztzAWO17FzG6bQFFrYo3OS_TI9AXyCEE7HEt3ET",
    "csBqXw2zTNqcPp1CEf7Z-B:APA91bFl367C_NxfKCpnYQGaK9HBpyGrbPVYMzHew7xSg5OK2rt3OLcuq6GnyqoLrYp2-C4Urys-rvDXEY7OLUvU4Ot1Rwd_rbBgo-oyfnCTkcBpVKsgjmX0SVsRFEJnTgN3gjcfBrU",
    "cKTW3CYJVUsfttyEJnMLPp:APA91bF6Emx0xFq9kGrsGZt3Y4MhjSgCzU16j_Oq6mJKwJwSe5rKeAB4Un3G7iUFnJTZBzJS-evoheY3nThQm25DVq-FNtmxbGS3ONDqC8e5Mb4ui5R21sOrKbyD0hS1CRHlbRF1ilfE"
  ]
}
"""
    
     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        try! Wigzo.initialize(orgToken: "6Srd_EenR5qIIKuQvEZa0g", forceInit: true)
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
//
        let pushNotification = PushNotification()
        pushNotification.sendLocalNotificationWithFile()
//
         // Present the in-app notification view controller
        
         coverJsonTOModel()
         

         if #available(iOS 10, *) {
                     UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ granted, error in
                         
                         UNUserNotificationCenter.current().delegate = self

                     }
                 } else { // iOS 9 support
                     application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
                 }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshToken(notification:)), name: Notification.Name.MessagingRegistrationTokenRefreshed, object: nil)
        
        application.registerForRemoteNotifications()
         DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                     // Code to be executed after the delay
             self.helper.showInAppNotificationViewController(payloadJson: self.notificationJson)
                 }

        return true
    }

     func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
             let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()

             print("apns token",token)
             Messaging.messaging().apnsToken = deviceToken

         }
     func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
             print("application didFailToRegisterForRemoteNotificationsWithError")
         }
   
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
     func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
         // Parse the deep link URL and decide what action to take in your app.
         if url.scheme == "demoInapp" {
             if url.host == "product" {
                 // Extract parameters or product ID from the URL
                 if let productID = url.queryParameters["id"] {
                     // Use the product ID to display the specific product in your app.
                     // Example: Navigate to the product detail screen.
                     //showProductDetail(productID)
                 }
             } else if url.host == "profile" {
                 // Handle profile-related deep linking.
                 // Example: Navigate to the user's profile.
                 //navigateToUserProfile()
             }
         }
         return true
     }
     
    
     func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler   completionHandler: @escaping (_ options: UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo as? [String: Any]
        print("userInfo = " , userInfo)
         
         
        // Check if the notification is a push notification
         if notification.request.content.userInfo["aps"] != nil {
             
             if let typeDict = userInfo?["type"] as? String,
                let pushType = convertStringToDictionary(text: typeDict),
                let organizationIdStr = userInfo?["organizationId"] as? String,
                let campaignIdStr = userInfo?["id"] as? String {
                 let image_url = userInfo?["image_url"] as? String
                 let title = userInfo?["title"] as? String
                 let body = userInfo?["body"] as? String
                 let layoutId = userInfo?["layoutId"] as? String
                 let isWigzoNotification = userInfo?["isWigzoNotification"] as? String
                 let intent_data = userInfo?["intent_data"] as? String
                 let campaignUuid = userInfo?["uuid"] as? String
                 
                 Messaging.messaging().appDidReceiveMessage(userInfo!)
                 if let messageID = userInfo?["messageIDKey"] as? String {
                     print("Message ID: \(messageID)")
                 }
                 
                 if let pushTypeValue = pushType["pushType"] as? String {
                     if pushTypeValue == "inapp" {

                        // let inAppNotificationVC = InAppNotificationViewController(image: <#UIImage#>)
//                         inAppNotificationVC.payload = notificationDataObject
//
//                         // Present or push the InAppNotificationViewController
//                         if let rootViewController = window?.rootViewController {
//                                                 rootViewController.present(inAppNotificationVC, animated: true, completion: nil)
//                                             }
//
//                                //  Create a new UIWindow
//                                 let inAppNotificationWindow = UIWindow(frame: UIScreen.main.bounds)
//                                 inAppNotificationWindow.windowLevel = .alert
//                                 //inAppNotificationWindow.rootViewController = inAppNotificationViewController
//
//
//                                 // Make the window visible
//                                 inAppNotificationWindow.makeKeyAndVisible()
                         
                         
                         
                         // Generate an in-app notification
                         //                         helper.showSwiftUISubview(imageUrlStr: image_url!, organizationIdStr: organizationIdStr,
                         //                                                   title: title!, body: body!, layoutId: layoutId!, isWigzoNotification: isWigzoNotification!,
                         //                                                   intent_data: intent_data!, campaignIdStr: campaignIdStr, campaignUuid: campaignUuid!)
                         // Create a payload for in-app notification
//                         let payload = MyPayload.Welcome(
//                             notification: MyPayload.Notification(mutableContent: 1, title: title),
//                             data: MyPayload.DataClass(
//                                 type: typeDictString,
//                                 id: Int(campaignIdStr) ?? 0,
//                                 title: title,
//                                 notificationID: 0,
//                                 imageURL: [image_url].compactMap { $0 },
//                                 secondSound: 0,
//                                 intentData: intent_data ?? "",
//                                 uuid: campaignUuid ?? "",
//                                 organizationID: Int(organizationIdStr) ?? 0,
//                                 layoutID: layoutId ?? "",
//                                 isWigzoNotification: isWigzoNotification == "true",
//                                 button: "", // You might need to format this based on the actual data structure
//                                 notificationDetails: MyPayload.NotificationDetails(
//                                    from: <#Decoder#>, buttonOrientation: "horizontal", // You might need to extract this from userInfo
//                                     templateOrientation: "top", // You might need to extract this from userInfo
//                                     templateBackground: "#fff", // You might need to extract this from userInfo
//                                     titleColor: "#000", // You might need to extract this from userInfo
//                                     titleFontSize: "14px", // You might need to extract this from userInfo
//                                     descriptionFontSize: "12px", // You might need to extract this from userInfo
//                                     descriptionFontColor: "#060101", // You might need to extract this from userInfo
//                                     isclose: "true", // You might need to extract this from userInfo
//                                     imageOrientation: "fullLayout", // You might need to extract this from userInfo
//                                     textAllignment: "center" // You might need to extract this from userInfo
//                                 )
//                             ),
//                             apns: MyPayload.Apns(
//                                from: <#Decoder#>, fcmOptions: MyPayload.FcmOptions(from: [image_url] as! Decoder),
//                                 payload: MyPayload.Payload(
//                                    from: MyPayload.Aps(from: <#Decoder#>, alert: MyPayload.Notification(from: <#Decoder#>, mutableContent: 1, title: title), mutableContent: false) as! Decoder
//                                 )
//                             ),
//                             registrationIDS: [] // You might need to format this based on the actual data structure
//                         )
                         completionHandler([.banner, .badge, .list, .sound])

                         
                         
                         
                     } else if pushTypeValue == "push" {
                         completionHandler([.banner, .badge, .list, .sound])
                     }
                     //                            else {
                     //                                // Handle other pushType values or do nothing
                     //                                helper.showSwiftUISubview(imageUrlStr: image_url!,organizationIdStr: organizationIdStr,
                     //                                                          title: title!, body: body!, layoutId: layoutId!, isWigzoNotification: isWigzoNotification!,
                     //                                                          intent_data: intent_data!, campaignIdStr: campaignIdStr, campaignUuid: campaignUuid!)
                     completionHandler([.banner, .badge, .list, .sound])
                     //
                     //                            }
                 } else {
                     // Handle the case where "pushType" is not found or do nothing
                 }
                 
                 if let organizationID = Int(organizationIdStr),
                    let campaignID = Int(campaignIdStr) {
                     
                     do {
                         // Handle both push and in-app notifications here
                         let notificationReceived = NotificationReceived(campaignId: organizationID, organizationId: campaignID)
                         try notificationReceived.push()
                     } catch {
                         print("Error while pushing notification received: \(error)")
                     }
                 }
             }
         }
                
        else{
            let pushNotification = PushNotification()
            pushNotification.handleNotification(notificationInfo: userInfo!)

        }
               //  Check if the notification is a local notification
        completionHandler([.alert, .sound, .badge])
         
    }
     

//     
//     func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
//         print("userINFO",response.notification.request.content.userInfo)
//         let dict = response.notification.request.content.userInfo
//         if response.actionIdentifier == "Action2Identifier" {
//             
//             guard let  buttonArray = dict["button"] as? [[String:AnyObject]] else {
//                 return
//             }
//             guard let buttonURLDict = buttonArray.last ,
//                   let buttonUrl = buttonURLDict["buttonUrl"]  else {
//                 return
//             }
//             print("button URL", buttonUrl)
//             //UIApplication.shared.open(buttonUrl as! URL, options: [:], completionHandler: nil)
//             
//             
//         }
//     }
    
     
   

     func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            let userInfo = response.notification.request.content.userInfo
            print("userInfo=",userInfo)
            if let organizationIDString = userInfo["organizationId"] as? String,
               let campaignIDString = userInfo["campaignID"] as? String,
               
               let organizationID = Int(organizationIDString),
               let campaignID = Int(campaignIDString) {

                do {
                    let notificationOpen = try NotificationOpen(campaignId: campaignID, organizationId: organizationID)
                    try notificationOpen.push()
                } catch {
                    // Handle the error here
                    print("Error: \(error)")
                }

                // Change this to your preferred presentation option
                completionHandler()
            } else {
                // Handle the case where conversion failed
            }
        completionHandler()

        }
//         func coverJsonTOModel() {
//             if let jsonData = notificationJson.data(using: .utf8) {
//                 do {
//                     let root = try JSONDecoder().decode(Root.self, from: jsonData)
//                     // Access your data model properties like this:
////                     let notification = root.notification
////                     let data = root.data
////                     let apns = root.apns
////                     let registrationIds = root.registration_ids
//                     print("conevrted notification object ===== \(root)")
//
//                 } catch {
//                     print("error on converting json to data model ==== \(error.localizedDescription)")
//                 }
//             }
//
//         }
     
     func coverJsonTOModel() {
         if let jsonData = notificationJson.data(using: .utf8) {
             do {
                 if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                     // Now you have the JSON data as a dictionary in the jsonObject variable.
                     // You can access its values as needed.
                     if let notification = jsonObject["notification"] as? [String: Any] {
                         if let mutableContent = notification["mutable-content"] as? Int,
                            let title = notification["title"] as? String {
                             // Access mutableContent and title here
                         }
                     }
                     
                     if let data = jsonObject["data"] as? [String: Any] {
                         // Parse data object and its properties
                     }
                     
                     if let apns = jsonObject["apns"] as? [String: Any] {
                         // Parse apns object and its properties
                     }
                     
                     if let registrationIds = jsonObject["registration_ids"] as? [String] {
                         // Parse registrationIds array
                     }
                     print("converted JSON === \(jsonObject)")
                 }
             } catch {
                 print("Error parsing JSON: \(error)")
             }
         }
     }

    @objc func refreshToken(notification: Notification) {
        }
         
         
         
    }
    extension AppDelegate: MessagingDelegate {
        public func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
            // Handle the received FCM token here
            print("Received FCM token: \(fcmToken ?? "No token")")

            // You can perform any necessary actions with the token, such as sending it to your server.
            // For example, you can create and send a request to update the token on your server.
            let fcmMapper = FCMMapper(registrationId: fcmToken ?? "")
            try? fcmMapper.push()

            let fcmRegister = FCMRegister(registrationId: fcmToken ?? "")
            try? fcmRegister.push()
        }
    }
extension URL {
    var queryParameters: [String: String] {
        var parameters = [String: String]()
        if let components = URLComponents(url: self, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems {
            for item in queryItems {
                if let value = item.value {
                    parameters[item.name] = value
                }
            }
        }
        return parameters
    }
}

class NotificationReceived {
    let campaignId: Int
    let organizationId: Int

    init(campaignId: Int, organizationId: Int) {
        self.campaignId = campaignId
        self.organizationId = organizationId
    }

    func push() {
        // Implement the logic to handle the push notification
        // This could include displaying the notification, opening a specific view, etc.
        // You should customize this method according to your requirements
        print("Received push notification for campaign \(campaignId) from organization \(organizationId)")
    }
}










