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



@main
public struct demo_inApp: App {

    public init() {}
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

     public var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    print("url.absoluteString",url)
                }
                
        }
       
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

public class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate{
    let helper = HelperClass()
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        try! Wigzo.initialize(orgToken: "MZ-bpDDYTIeem9nz8P4Icg", forceInit: true)
        
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in
                UNUserNotificationCenter.current().delegate = self
                
            }
            
        )
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshToken(notification:)), name: Notification.Name.MessagingRegistrationTokenRefreshed, object: nil)
        
        application.registerForRemoteNotifications()
        return true
    }

    
    func application(_application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
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
    public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                       willPresent notification: UNNotification,
                                       withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
       

let userInfo = notification.request.content.userInfo as? [String: Any]

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
                    // Generate an in-app notification
                    helper.showSwiftUISubview(imageUrlStr: image_url!, organizationIdStr: organizationIdStr,
                                              title: title!, body: body!, layoutId: layoutId!, isWigzoNotification: isWigzoNotification!,
                                              intent_data: intent_data!, campaignIdStr: campaignIdStr, campaignUuid: campaignUuid!)
                } else if pushTypeValue == "push" {
                    // Generate a push notification
                    // Handle push notification logic here

                    // Complete the handler to display the push notification
                    completionHandler([.banner, .badge, .list, .sound])
                } else {
                    // Handle other pushType values or do nothing
                    helper.showSwiftUISubview(imageUrlStr: image_url!, organizationIdStr: organizationIdStr,
                                              title: title!, body: body!, layoutId: layoutId!, isWigzoNotification: isWigzoNotification!,
                                              intent_data: intent_data!, campaignIdStr: campaignIdStr, campaignUuid: campaignUuid!)
                    completionHandler([.banner, .badge, .list, .sound])

                }
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
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
            print("Device Token:", token)
        }

    public func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
            print("Failed to register for remote notifications:", error.localizedDescription)
       }
   

    public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                           didReceive response: UNNotificationResponse,
                                           withCompletionHandler completionHandler: @escaping () -> Void) {
            let userInfo = response.notification.request.content.userInfo
            print(userInfo)
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
//extension AppDelegate {
//
//    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
//
//        print(url.absoluteString)
//        return true
//    }
//}

protocol DeeplinkHandlerProtocol {
    func canOpenURL(_ url: URL) -> Bool
    func openURL(_ url: URL)
}

final class AccountDeeplinkHandler: DeeplinkHandlerProtocol {
    private weak var rootViewController: UIViewController?
    
    init(rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }
    
    func canOpenURL(_ url: URL) -> Bool {
        return url.absoluteString == "demoInapp://DestinationView"
    }
    
    func openURL(_ url: URL) {
        guard canOpenURL(url) else {
            return
        }
        
        // Instantiate your view controller using the appropriate type
        let hostingController = UIHostingController(rootView: DestinationView())
        rootViewController?.present(hostingController, animated: true)
    }
}
protocol DeeplinkCoordinatorProtocol {
    @discardableResult
    func handleURL(_ url: URL) -> Bool
}

final class DeeplinkCoordinator: DeeplinkCoordinatorProtocol {
    static let shared = DeeplinkCoordinator()
    var handlers: [DeeplinkHandlerProtocol] = []
    
    func registerHandler(_ handler: DeeplinkHandlerProtocol) {
        handlers.append(handler)
    }
    
    @discardableResult
    func handleURL(_ url: URL) -> Bool {
        guard let handler = handlers.first(where: { $0.canOpenURL(url) }) else {
            return false
        }
        handler.openURL(url)
        return true
    }
}


extension AppDelegate {
    static var window: UIWindow?
    static var deeplinkCoordinator: DeeplinkCoordinatorProtocol = DeeplinkCoordinator.shared as DeeplinkCoordinatorProtocol
    
    var rootViewController: UIViewController? {
        return AppDelegate.window?.rootViewController
    }
}
extension AppDelegate {
    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        // Handle the URL using the DeeplinkCoordinator
        return AppDelegate.deeplinkCoordinator.handleURL(url)
    }
}











