//
//  AppDelegate.swift
//  demo_inApp
//
//  Created by Shivam on 08/08/23.
//

//import SwiftUI
//import FirebaseCore
//
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
//
//    return true
//  }
//}
//
//@main
////struct YourApp: App {
//  // register app delegate for Firebase setup
//struct demo_inAppApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}
//  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//
//
////  var body: some Scene {
////    WindowGroup {
////      NavigationView {
////        ContentView()
////      }
////    }
////  }
//}
//import SwiftUI
//import FirebaseCore
//
//@main
//struct demo_inApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//        return true
//    }
//
//
//}
import UIKit
import Firebase
import UserNotifications
import FirebaseMessaging
import SwiftUI
import WigzoiOSSDK




@main
struct demo_inApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate{


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self

        try! Wigzo.initialize(orgToken: "6Srd_EenR5qIIKuQvE Za0g")



        FirebaseApp.configure()
       // Messaging.messaging().delegate = self
       



        // InAppMessaging.inAppMessaging().delegate = self
        return true
        //        var eventMapper = EventMapper()
        //        var eventData = EventData()
        //
        //        eventData.setEventName(eventName: "view")
        //        eventData.setEventValue(eventValue: "productView")
        //
        //        eventMapper.setEventData(eventData: eventData)
        //        try! eventMapper.push()
        //        eventMapper.setEventData(eventData: eventData)
        //
        //        var userProfileMapper = UserProfileMapper()
        //        userProfileMapper = userProfileMapper.setEmail(email: "shivam.ratnam@wigzo.com")
        //        userProfileMapper = userProfileMapper.setPhone(phone: "7667781946")
        //        userProfileMapper = userProfileMapper.setGender(gender: "Male")
        //        userProfileMapper = userProfileMapper.setOrganization(organization: "Wigzo")
        //        userProfileMapper = userProfileMapper.setFullName(fullName: "Shivam Ratnam")
        //        userProfileMapper = userProfileMapper.setUserName(userName: "shivam")
        //        userProfileMapper = userProfileMapper.setBirthYear(birthYear: "1998")
        //
        //        try! userProfileMapper.push()
        //        let userEmailMapper = UserEmailMapper(email: "shivam.ratnam@wigzo.com")
        //        try! userEmailMapper.push()
        
      



    }
}






    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Device Token:", token)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications:", error.localizedDescription)
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {


        let fcmMapper : FCMMapper = FCMMapper(registrationId: fcmToken!)
        try! fcmMapper.push()

        let fcmRegister : FCMRegister = FCMRegister(registrationId: fcmToken!)
        try! fcmRegister.push()
    }
//        func messaging(_ messaging: Messaging, didReceive remoteMessage: [AnyHashable: Any]) {
//               handleNotification(data: remoteMessage)
//           }
    //
    //       func handleNotification(data: [AnyHashable: Any]) {
    //           if let aps = data["aps"] as? [String: Any],
    //              let alert = aps["alert"] as? [String: Any],
    //              let title = alert["title"] as? String,
    //              let body = alert["body"] as? String {
    //
    //               let contentView = Template1(title: title, description: body)
    //               // Now you can use this contentView to display the dynamic notification data in your app
    //               // You might present it modally or integrate it into your app's UI hierarchy
    //           }
    //       }
    //
    //       // ... (other delegate methods)
    //   }
    // Implement other delegate methods as needed

    // Handle notifications received while the app is in the foreground

    //    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    //        // Customize how the notification is displayed when the app is active
    //      //  print("hello from firebase notification listner")
    //        completionHandler([.badge, .sound, .banner])
    //    }
    //
    //  //   Handle notifications when the user taps on them
    //    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    //        // Handle the notification content
    //       // print("hello from firebase notification listner")
    //        completionHandler()
    //
    //    }


extension AppDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo

        let image_url = userInfo["image_url"] as? String
        let organizationIdStr = (userInfo["organizationId"] as? String)!
        let title = userInfo["title"] as? String
        let body = userInfo["body"] as? String
        let layoutId = userInfo["layoutId"] as? String
        let isWigzoNotification = userInfo["isWigzoNotification"] as? String
        let intent_data = userInfo["intent_data"] as? String
        let campaignIdStr = (userInfo["id"] as? String)!
        let campaignUuid = userInfo["uuid"] as? String
       Messaging.messaging().appDidReceiveMessage(userInfo)
        if let messageID = userInfo["messageIDKey"] as? String {
            print("Message ID: \(messageID)")
    }
   //   Template1(title: title!, description: body!,imageUrl: URL(string: "image_url")!)
        print(userInfo)
       // showSwiftUIPopup()
        showSwiftUISubview()
        if let organizationID = Int(organizationIdStr),
           let campaignID = Int(campaignIdStr) {

            do {
                let notificationRecieved = NotificationRecieved(campaignId: organizationID, organizationId: campaignID)
                try notificationRecieved.push()
                completionHandler([.banner, .badge, .list, .sound])
            } catch {
                print("Error while pushing notification received: \(error)")
            }
        }
    }
}
    func showSwiftUIPopup() {



             let window = UIApplication.shared.keyWindow
        let popupView = Template1(title:"hii", description:"shivam",imageUrl: URL(string: "")!)

            let popupViewController = UIHostingController(rootView: popupView)

            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            alertController.setValue(popupViewController, forKey: "contentViewController")

            if let rootViewController = window?.rootViewController {
                rootViewController.present(alertController, animated: true, completion: nil)
            }
        }
func showSwiftUISubview() {
    // Create your SwiftUI subview
    let swiftUISubview = Template1(title:"hii", description:"prashant1",imageUrl: URL(string: "")!)// Replace with your SwiftUI subview

    // Find the currently visible view controller
    if let topViewController = findTopViewController() {
        // Create a UIHostingController for the SwiftUI subview
        let hostingController = UIHostingController(rootView: swiftUISubview)

        // Add the hosting controller's view as a subview to the visible view controller's view
        topViewController.view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: topViewController.view.leadingAnchor, constant: 20),
            hostingController.view.trailingAnchor.constraint(equalTo: topViewController.view.trailingAnchor, constant: -20),
            hostingController.view.centerYAnchor.constraint(equalTo: topViewController.view.centerYAnchor), // Center vertically
            hostingController.view.heightAnchor.constraint(equalToConstant: 300)
        ])

        // Associate the hosting controller with the visible view controller
        topViewController.addChild(hostingController)
        hostingController.didMove(toParent: topViewController)
    }
}


    func findTopViewController() -> UIViewController? {
        let window = UIApplication.shared.keyWindow
        if let rootViewController = window?.rootViewController {
            var topViewController = rootViewController
            while let presentedViewController = topViewController.presentedViewController {
                topViewController = presentedViewController
            }
            return topViewController
        }
        return nil
    }













extension AppDelegate{
        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    didReceive response: UNNotificationResponse,
                                    withCompletionHandler completionHandler: @escaping () -> Void) {
            let userInfo = response.notification.request.content.userInfo
            print(userInfo)

//            image_url
//            organizationId
//            title
//            body
//            layoutId
//            isWigzoNotification
//            intent_data
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
        }
    }






