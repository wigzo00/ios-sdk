//
//  File.swift
//  
//
//  Created by Shivam Ratnam on 04/10/23.
//
import Foundation
import UserNotifications
import UIKit

public class PushNotification{
    public init() {
        // Initialization code here
    }
    weak var delegate: PushNotificationHandlerDelegate?
    
    
    func handlePushNotification(userInfo: [AnyHashable: Any]) {
        guard let typeString = userInfo["type"] as? String,
              let type = NotificationType(rawValue: typeString) else {
            print("Invalid notification type")
            return
        }
        
        let notification = NotificationModel(userInfo: userInfo, type: type)
        delegate?.handlePushNotification(notification: notification)
    }
    
    public func sendLocalNotificationWithFile(){
        
        if let path = Bundle.main.path(forResource: "Test", ofType: "json") {
            do {
                let data = try! Data(contentsOf: URL(fileURLWithPath: path))
                let notificationInfo = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
                
                
                let content = UNMutableNotificationContent()
                content.title = notificationInfo["title"] as? String ?? "Default Title"
                content.body = "Lorem Ipsum dolor sit amet Lorem Ipsum dolor sit "
                content.sound = UNNotificationSound.default
                if let imageUrl = notificationInfo["imageUrL"] as? String {
                    
                }
                
                let action1 = UNNotificationAction(identifier: "Action1Identifier", title: "Button 1", options: [])
                let action2 = UNNotificationAction(identifier: "Action2Identifier", title: "Button 2", options: [])
                //  let categoryIdentifier = "carousel"
               //  let categoryIdentifier = "image"
                //let categoryIdentifier = "text"
                let categoryIdentifier = "video"
                
                let category = UNNotificationCategory(identifier:categoryIdentifier, actions: [action1, action2], intentIdentifiers: [], options: [])
                
                // Register the category with the notification center
                UNUserNotificationCenter.current().setNotificationCategories([category])
                
                // Set the category identifier for the notification content
                content.categoryIdentifier = categoryIdentifier
                // Register the category with the notification center
                UNUserNotificationCenter.current().setNotificationCategories([category])
                content.userInfo = notificationInfo
                
                // Set the notification trigger for immediate display
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
                
                // Request permission for notifications
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                    if granted {
                        // Schedule the notification
                        let request = UNNotificationRequest(identifier: "LocalNotification", content: content, trigger: trigger)
                        UNUserNotificationCenter.current().add(request) { error in
                            if let error = error {
                                print("Failed to schedule notification: \(error.localizedDescription)")
                            } else {
                                print("Local notification scheduled successfully.")
                            }
                        }
                        
                        print("Notification permission granted.")
                        //                        PushNotification.sendLocalNotification()
                    } else {
                        print("Notification permission denied: \(error?.localizedDescription ?? "Unknown error")")
                    }
                }
                
                // Now you have the JSON data as a Foundation object (typically a Dictionary or an Array).
                // You can parse it further using Swift Codable or by casting to appropriate types.
                
            } catch {
                print("Error reading JSON file: \(error)")
            }
        } else {
            print("JSON file not found.")
        }
        
        
    }
    
    public func handleNotification(notificationInfo: [String: Any]){
        
        //        let intentData = notificationInfo["intentData"] as? [String: Any] ?? [:]
        //                let button = notificationInfo["button"] as? [[String: String]] ?? []
        //                let layoutId = notificationInfo["layoutId"] as? String ?? "Default Layout ID"
        //                let organizationId = notificationInfo["organizationId"] as? String ?? "Default Organization ID"
        //                let imageUrls = notificationInfo["imageUrL"] as? [String] ?? []
        //                let isWigzoNotification = notificationInfo["isWigzoNotification"] as? String ?? "false"
        //                let id = notificationInfo["id"] as? String ?? "Default ID"
        //                let type = (notificationInfo["type"] as? [String: String])?["type"] ?? "Default Type"
        //                let uuid = notificationInfo["uuid"] as? String ?? "Default UUID"
        //                let title = notificationInfo["title"] as? String ?? "Default Title"
        //                let secondSound = notificationInfo["secondSound"] as? Int ?? 0
        //                let notificationId = notificationInfo["notificationId"] as? Int ?? 0
        //
        if let intentData = notificationInfo["intentData"] as? [String: Any],
           let organizationId = notificationInfo["organizationId"] as? Int,
           let id = notificationInfo["id"] as? Int,
           let isWigzoNotification = notificationInfo["isWigzoNotification"] as? Bool,
           let body = notificationInfo["body"] as? String,
           let googleCAE = notificationInfo["google.c.a.e"] as? Int,
           let googleSenderID = notificationInfo["google.c.sender.id"] as? Int64,
           let googleCFID = notificationInfo["google.c.fid"] as? String,
           let secondSound = notificationInfo["secondSound"] as? Int,
           let gcmMessageID = notificationInfo["gcm.message_id"] as? String,
           let uuid = notificationInfo["uuid"] as? String,
           let imageUrls = notificationInfo["imageUrl"] as? [String],
           let aps = notificationInfo["aps"] as? [String: Any],
           let alert = aps["alert"] as? [String: String],
           let title = alert["title"] {
            
            // Now you can use these variables as needed within your function
            print("intentData:", intentData)
            print("organizationId:", organizationId)
            print("id:", id)
            print("isWigzoNotification:", isWigzoNotification)
            print("body:", body)
            print("googleCAE:", googleCAE)
            print("googleSenderID:", googleSenderID)
            print("googleCFID:", googleCFID)
            print("secondSound:", secondSound)
            print("gcmMessageID:", gcmMessageID)
            print("uuid:", uuid)
            print("imageUrls:", imageUrls)
            print("aps title:", title)
        }
       
    }
}



protocol PushNotificationHandlerDelegate: AnyObject {
    func handlePushNotification(notification: NotificationModel)
}


struct NotificationModel {
    let type: NotificationType
    let title: String?
    let body: String?
    let imageURL: URL?
    let videoURL: URL?
    let timerDuration: TimeInterval?
    
    init(userInfo: [AnyHashable: Any], type: NotificationType) {
        self.type = type
        self.title = userInfo["title"] as? String
        self.body = userInfo["body"] as? String
        self.imageURL = URL(string: userInfo["image_url"] as? String ?? "")
        self.videoURL = URL(string: userInfo["video_url"] as? String ?? "")
        self.timerDuration = userInfo["timer_duration"] as? TimeInterval
    }
}

enum NotificationType: String {
    case text = "text"
    case image = "image"
    case video = "video"
    case timer = "timer"
}

func sendRichNotification() {
    let content = UNMutableNotificationContent()
    content.title = "Rich Notification"
    content.body = "This is a rich notification with an image."
    
    // Add an image attachment
    let attachement = try! UNNotificationAttachment(identifier: "Image",
                                                    url: Bundle.main.url(forResource: "AppIcon", withExtension: "jpg")!,
                                                    options: nil)
    
    content.attachments = [attachement].compactMap { $0 }
    
    let request = UNNotificationRequest(identifier: "richNotification", content: content, trigger: nil)
    
    UNUserNotificationCenter.current().add(request) { (error) in
        if let error = error {
            print("Error sending rich notification: \(error.localizedDescription)")
        }
    }
}
