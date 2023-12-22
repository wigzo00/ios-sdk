//
//  File.swift
//
//
//  Created by Shivam on 24/08/23.
//
//

import UIKit
import SwiftUI
@available(iOS 13.0, *)
public class HelperClass{
    var notificationDataModel:NotificationModel?
    var notificationData:NotificationData?
    public init() {
        // Initialization code here
    }
    @State private var isTemplate1Presented = false
    var hostingControllerTemplate1: UIHostingController<Template1>?
    var template1:Template1?
    private var isTemplate1PresentedBinding: Binding<Bool> {
        Binding(
            get: { self.isTemplate1Presented },
            set: { newValue in
                self.isTemplate1Presented = newValue
                if !newValue {
                    // Hide the Template1 view when isTemplate1Presented becomes false
                    
                    self.hostingControllerTemplate1?.view.removeFromSuperview()
                }
            }
        )
    }
    
    @State private var isTemplate2Presented = false
    var hostingControllerTemplate2: UIHostingController<Template2>?
    var template2:Template2?
    
    
    private var isTemplate2PresentedBinding: Binding<Bool> {
        Binding(
            get: { self.isTemplate2Presented },
            set: { newValue in
                self.isTemplate2Presented = newValue
                if !newValue {
                    // Hide the Template1 view when isTemplate1Presented becomes false
                    
                    self.hostingControllerTemplate2?.view.removeFromSuperview()
                }
            }
        )
    }
    @State private var isTemplate3Presented = false
    var hostingControllerTemplate3: UIHostingController<Template3>?
    var template3:Template3?
    
    
    private var isTemplate3PresentedBinding: Binding<Bool> {
        Binding(
            get: { self.isTemplate3Presented },
            set: { newValue in
                self.isTemplate3Presented = newValue
                if !newValue {
                    // Hide the Template1 view when isTemplate1Presented becomes false
                    
                    self.hostingControllerTemplate3?.view.removeFromSuperview()
                }
            }
        )
    }
    @State private var isTemplate4Presented = false
    var hostingControllerTemplate4: UIHostingController<Template4>?
    var template4:Template4?
    
    
    private var isTemplate4PresentedBinding: Binding<Bool> {
        Binding(
            get: { self.isTemplate4Presented },
            set: { newValue in
                self.isTemplate4Presented = newValue
                if !newValue {
                    self.hostingControllerTemplate4?.view.removeFromSuperview()
                }
            }
        )
    }
    
    
    @State private var isTemplate5Presented = false
    var hostingControllerTemplate5: UIHostingController<Template5>?
    var template5:Template5?
    
    
    private var isTemplate5PresentedBinding: Binding<Bool> {
        Binding(
            get: { self.isTemplate5Presented },
            set: { newValue in
                self.isTemplate5Presented = newValue
                if !newValue {
                    // Hide the Template1 view when isTemplate1Presented becomes false
                    
                    self.hostingControllerTemplate5?.view.removeFromSuperview()
                }
            }
        )
    }
    @State private var isTemplate6Presented = false
    var hostingControllerTemplate6: UIHostingController<Template6>?
    var template6:Template6?
    
    
    private var isTemplate6PresentedBinding: Binding<Bool> {
        Binding(
            get: { self.isTemplate6Presented },
            set: { newValue in
                self.isTemplate6Presented = newValue
                if !newValue {
                    // Hide the Template1 view when isTemplate1Presented becomes false
                    
                    self.hostingControllerTemplate6?.view.removeFromSuperview()
                }
            }
        )
    }
    @State private var isTemplate7Presented = false
    var hostingControllerTemplate7: UIHostingController<Template7>?
    var template7:Template7?
    
    
    private var isTemplate7PresentedBinding: Binding<Bool> {
        Binding(
            get: { self.isTemplate7Presented },
            set: { newValue in
                self.isTemplate7Presented = newValue
                if !newValue {
                    // Hide the Template1 view when isTemplate1Presented becomes false
                    
                    self.hostingControllerTemplate7?.view.removeFromSuperview()
                }
            }
        )
    }
    @available(iOS 16.0, *)
    public func showSwiftUISubview(imageUrlStr : String, organizationIdStr : String, title : String,
                                   body : String, layoutId : String, isWigzoNotification : String,
                                   intent_data : String, campaignIdStr : String, campaignUuid : String) {
        let imageUrl = URL(string: imageUrlStr)!
        if let topViewController = findTopViewController(),layoutId == "007" {
            // Create a container view that covers the entire screen
            let swiftUISubview  = Template1( title: title, description: body, imageUrl: imageUrl,isPresented: isTemplate1PresentedBinding)
            
            let containerView = UIView(frame: topViewController.view.bounds)
            
            // Set the background color of the container view to clear or with transparency
            containerView.backgroundColor = UIColor.clear
            
            // Add the container view as a subview to the visible view controller's view
            topViewController.view.addSubview(containerView)
            
            // Add the SwiftUI subview to the container view
            hostingControllerTemplate1 = UIHostingController(rootView: swiftUISubview)
            if let hostingControllerTemplate1 = hostingControllerTemplate1 {
                containerView.addSubview(hostingControllerTemplate1.view)
                
                // Calculate the width and height of Template1
                let template1Width: CGFloat = 320 // Calculate the width of Template1
                let template1Height: CGFloat = 490 // Calculate the height of Template1
                
                // Apply constraints to make swiftUISubview match the size of Template1
                hostingControllerTemplate1.view.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    hostingControllerTemplate1.view.widthAnchor.constraint(equalToConstant: template1Width),
                    hostingControllerTemplate1.view.heightAnchor.constraint(equalToConstant: template1Height),
                    hostingControllerTemplate1.view.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                    hostingControllerTemplate1.view.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
                ])
                
                // Associate the hosting controller with the visible view controller
                topViewController.addChild(hostingControllerTemplate1)
                hostingControllerTemplate1.didMove(toParent: topViewController)
            }
        }
        if let topViewController = findTopViewController(),layoutId == "006"{
            // Create a container view that covers the entire screen
            let swiftUISubview1 = Template2( title: title, description: body, imageUrl: imageUrl,isPresented: isTemplate2PresentedBinding)
            
            let containerView = UIView(frame: topViewController.view.bounds)
            
            // Set the background color of the container view to clear or with transparency
            containerView.backgroundColor = UIColor.clear
            
            // Add the container view as a subview to the visible view controller's view
            topViewController.view.addSubview(containerView)
            
            // Add the SwiftUI subview to the container view
            hostingControllerTemplate2 = UIHostingController(rootView: swiftUISubview1)
            if let hostingControllerTemplate2 = hostingControllerTemplate2 {
                containerView.addSubview(hostingControllerTemplate2.view)
                
                // Calculate the width and height of Template1
                let template2Width: CGFloat = 310
                let template2Height: CGFloat = 412
                
                // Apply constraints to make swiftUISubview match the size of Template1
                hostingControllerTemplate2.view.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    hostingControllerTemplate2.view.widthAnchor.constraint(equalToConstant: template2Width),
                    hostingControllerTemplate2.view.heightAnchor.constraint(equalToConstant: template2Height),
                    hostingControllerTemplate2.view.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                    hostingControllerTemplate2.view.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
                ])
                
                // Associate the hosting controller with the visible view controller
                topViewController.addChild(hostingControllerTemplate2)
                hostingControllerTemplate2.didMove(toParent: topViewController)
            }
        }
        if let topViewController = findTopViewController(),layoutId == "004" {
            // Create a container view that covers the entire screen
            let swiftUISubview2 = Template3( title: title, description: body, imageUrl: imageUrl,isPresented: isTemplate3PresentedBinding)
            
            let containerView = UIView(frame: topViewController.view.bounds)
            
            // Set the background color of the container view to clear or with transparency
            containerView.backgroundColor = UIColor.clear
            
            
            // Add the container view as a subview to the visible view controller's view
            topViewController.view.addSubview(containerView)
            
            // Add the SwiftUI subview to the container view
            hostingControllerTemplate3 = UIHostingController(rootView: swiftUISubview2)
            if let hostingControllerTemplate3 = hostingControllerTemplate3 {
                containerView.addSubview(hostingControllerTemplate3.view)
                // Calculate the width and height of Template1
                let template3Width: CGFloat = 350 // Calculate the width of Template1
                let template3Height: CGFloat = 390// Calculate the height of Template1
                
                // Apply constraints to make swiftUISubview match the size of Template1
                hostingControllerTemplate3.view.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    hostingControllerTemplate3.view.widthAnchor.constraint(equalToConstant: template3Width),
                    hostingControllerTemplate3.view.heightAnchor.constraint(equalToConstant: template3Height),
                    hostingControllerTemplate3.view.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                    hostingControllerTemplate3.view.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                    
                ])
                
                
                // Associate the hosting controller with the visible view controller
                topViewController.addChild(hostingControllerTemplate3)
                hostingControllerTemplate3.didMove(toParent: topViewController)
            }
        }
        if let topViewController = findTopViewController(),layoutId == "005" {
            // Create a container view that covers the entire screen
            let swiftUISubview3 = Template4( title: title, description: body, imageUrl: imageUrl,isPresented: isTemplate4PresentedBinding)
            
            let containerView = UIView(frame: topViewController.view.bounds)
            
            // Set the background color of the container view to clear or with transparency
            containerView.backgroundColor = UIColor.clear
            
            // Add the container view as a subview to the visible view controller's view
            topViewController.view.addSubview(containerView)
            
            // Add the SwiftUI subview to the container view
            hostingControllerTemplate4 = UIHostingController(rootView: swiftUISubview3)
            if let hostingControllerTemplate4 = hostingControllerTemplate4 {
                containerView.addSubview(hostingControllerTemplate4.view)
                
                // Calculate the width and height of Template1
                let template4Width: CGFloat = 310 // Calculate the width of Template1
                let template4Height: CGFloat = 350 // Calculate the height of Template1
                
                // Apply constraints to make swiftUISubview match the size of Template1
                hostingControllerTemplate4.view.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    hostingControllerTemplate4.view.widthAnchor.constraint(equalToConstant: template4Width),
                    hostingControllerTemplate4.view.heightAnchor.constraint(equalToConstant: template4Height),
                    hostingControllerTemplate4.view.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                    hostingControllerTemplate4.view.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
                ])
                
                // Associate the hosting controller with the visible view controller
                topViewController.addChild(hostingControllerTemplate4)
                hostingControllerTemplate4.didMove(toParent: topViewController)
            }
        }
        if let topViewController = findTopViewController(),layoutId == "001" {
            // Create a container view that covers the entire screen
            let swiftUISubview4 = Template5( title: title, description: body, imageUrl: imageUrl,isPresented: isTemplate5PresentedBinding)
            
            let containerView = UIView(frame: topViewController.view.bounds)
            
            // Set the background color of the container view to clear or with transparency
            containerView.backgroundColor = UIColor.clear
            
            // Add the container view as a subview to the visible view controller's view
            topViewController.view.addSubview(containerView)
            
            // Add the SwiftUI subview to the container view
            hostingControllerTemplate5 = UIHostingController(rootView: swiftUISubview4)
            if let hostingControllerTemplate5 = hostingControllerTemplate5 {
                containerView.addSubview(hostingControllerTemplate5.view)
                
                // Calculate the width and height of Template1
                let template5Width: CGFloat = 310 // Calculate the width of Template1
                let template5Height: CGFloat = 500// Calculate the height of Template1
                
                // Apply constraints to make swiftUISubview match the size of Template1
                hostingControllerTemplate5.view.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    hostingControllerTemplate5.view.widthAnchor.constraint(equalToConstant: template5Width),
                    hostingControllerTemplate5.view.heightAnchor.constraint(equalToConstant: template5Height),
                    hostingControllerTemplate5.view.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                    hostingControllerTemplate5.view.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
                ])
                
                // Associate the hosting controller with the visible view controller
                topViewController.addChild(hostingControllerTemplate5)
                hostingControllerTemplate5.didMove(toParent: topViewController)
            }
        }
        if let topViewController = findTopViewController(),layoutId == "002"{
            // Create a container view that covers the entire screen
            let swiftUISubview5 = Template6( title: title, description: body, imageUrl: imageUrl,isPresented: isTemplate6PresentedBinding)
            
            let containerView = UIView(frame: topViewController.view.bounds)
            
            // Set the background color of the container view to clear or with transparency
            containerView.backgroundColor = UIColor.clear
            
            // Add the container view as a subview to the visible view controller's view
            topViewController.view.addSubview(containerView)
            
            // Add the SwiftUI subview to the container view
            hostingControllerTemplate6 = UIHostingController(rootView: swiftUISubview5)
            if let hostingControllerTemplate6 = hostingControllerTemplate6 {
                containerView.addSubview(hostingControllerTemplate6.view)
                
                // Calculate the width and height of Template1
                let template6Width: CGFloat = 310 // Calculate the width of Template1
                let template6Height: CGFloat = 500 // Calculate the height of Template1
                
                // Apply constraints to make swiftUISubview match the size of Template1
                hostingControllerTemplate6.view.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    hostingControllerTemplate6.view.widthAnchor.constraint(equalToConstant: template6Width),
                    hostingControllerTemplate6.view.heightAnchor.constraint(equalToConstant: template6Height),
                    hostingControllerTemplate6.view.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                    hostingControllerTemplate6.view.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
                ])
                
                // Associate the hosting controller with the visible view controller
                topViewController.addChild(hostingControllerTemplate6)
                hostingControllerTemplate6.didMove(toParent: topViewController)
            }
        }
        if let topViewController = findTopViewController(),layoutId == "003" {
            // Create a container view that covers the entire screen
            let swiftUISubview6 = Template7( title: title, description: body, imageUrl: imageUrl,isPresented: isTemplate7PresentedBinding)
            
            let containerView = UIView(frame: topViewController.view.bounds)
            
            // Set the background color of the container view to clear or with transparency
            containerView.backgroundColor = UIColor.clear
            
            // Add the container view as a subview to the visible view controller's view
            topViewController.view.addSubview(containerView)
            
            // Add the SwiftUI subview to the container view
            hostingControllerTemplate7 = UIHostingController(rootView: swiftUISubview6)
            if let hostingControllerTemplate7 = hostingControllerTemplate7 {
                containerView.addSubview(hostingControllerTemplate7.view)
                
                // Calculate the width and height of Template1
                let template7Width: CGFloat = 310 // Calculate the width of Template1
                let template7Height: CGFloat = 500 // Calculate the height of Template1
                
                // Apply constraints to make swiftUISubview match the size of Template1
                hostingControllerTemplate7.view.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    hostingControllerTemplate7.view.widthAnchor.constraint(equalToConstant: template7Width),
                    hostingControllerTemplate7.view.heightAnchor.constraint(equalToConstant: template7Height),
                    hostingControllerTemplate7.view.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                    hostingControllerTemplate7.view.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
                ])
                
                // Associate the hosting controller with the visible view controller
                topViewController.addChild(hostingControllerTemplate7)
                hostingControllerTemplate7.didMove(toParent: topViewController)
            }
        }
    }
    
    public  func findTopViewController() -> UIViewController? {
        let window = UIApplication.shared.keyWindow
        
        if let rootViewController = window?.rootViewController {
            var topViewController = rootViewController
            while let presentedViewController = topViewController.presentedViewController {
                topViewController = presentedViewController
                
            }
           // topViewController.view.addSubview(UILabel)
            return topViewController
        }
        return nil
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
        
        public func sendLocalPushNotification(from userInfo: [String: Any]) {
            guard let typeDict = userInfo["type"] as? String,
                  let pushType = convertStringToDictionary(text: typeDict),
                  let organizationIdStr = userInfo["organizationId"] as? String,
                  let campaignIdStr = userInfo["id"] as? String,
                  let title = userInfo["title"] as? String,
                  let body = userInfo["body"] as? String else {
                print("Invalid payload for local push notification")
                return
            }
    
            // Extract other payload information as needed
            let image_url = userInfo["image_url"] as? String
            let layoutId = userInfo["layoutId"] as? String
            let isWigzoNotification = userInfo["isWigzoNotification"] as? String
            let intent_data = userInfo["intent_data"] as? String
            let campaignUuid = userInfo["uuid"] as? String
    
            // Handle payload data...
    
            // Now, use the title and body to create a local push notification
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.sound = UNNotificationSound.default
    
            // Deliver the notification immediately
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
    
            // Add the notification to the notification center
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error sending local push notification: \(error)")
                } else {
                    print("Local push notification sent successfully")
                }
            }
        }

        
    
    
    
}
@available(iOS 13.0, *)

// version V2
extension HelperClass {
    public func showInAppNotificationViewController(payloadJson: WigzoNotification1?) {
        guard let topViewController = findTopViewController() else {
            return
        }

        
        print("image obj : ===== \(payloadJson?.imageURL)")
        print("noti obj : ===== \(payloadJson?.notificationDetails)")
        
        let inAppNotificationViewController = InAppNotificationViewController()

        // Pass data to InAppNotificationViewController
        inAppNotificationViewController.payload = payloadJson

        // Add InAppNotificationViewController as a child view controller
        topViewController.addChild(inAppNotificationViewController)
        inAppNotificationViewController.view.translatesAutoresizingMaskIntoConstraints = false

        // Set the background color for InAppNotificationViewController

        // Add InAppNotificationViewController's view to the parent view
        topViewController.view.addSubview(inAppNotificationViewController.view)

        // Define constraints to center it and set a desired size
        if inAppNotificationViewController.payload?.notificationDetails?.templateOrientation?.lowercased() == "top"{
            
            
            
            NSLayoutConstraint.activate([
                inAppNotificationViewController.view.leadingAnchor.constraint(equalTo: topViewController.view.leadingAnchor, constant: 10),
                inAppNotificationViewController.view.trailingAnchor.constraint(equalTo: topViewController.view.trailingAnchor, constant: -10),
                inAppNotificationViewController.view.topAnchor.constraint(equalTo: topViewController.view.topAnchor, constant: 50),
              
            ])
               
        }
        else if inAppNotificationViewController.payload?.notificationDetails?.templateOrientation?.lowercased() == "middle"{
            NSLayoutConstraint.activate([
                inAppNotificationViewController.view.centerXAnchor.constraint(equalTo: topViewController.view.centerXAnchor),
                       inAppNotificationViewController.view.centerYAnchor.constraint(equalTo: topViewController.view.centerYAnchor),
                       inAppNotificationViewController.view.widthAnchor.constraint(equalTo: topViewController.view.widthAnchor, multiplier: 0.8), // Adjust multiplier as needed
                       inAppNotificationViewController.view.heightAnchor.constraint(equalTo: topViewController.view.heightAnchor, multiplier: 0.6), // Adjust multiplier as needed
                
            ])
        }
        else if inAppNotificationViewController.payload?.notificationDetails?.templateOrientation?.lowercased() == "footer"  {
            NSLayoutConstraint.activate([
                inAppNotificationViewController.view.leadingAnchor.constraint(equalTo: topViewController.view.leadingAnchor, constant: 6),
                inAppNotificationViewController.view.trailingAnchor.constraint(equalTo: topViewController.view.trailingAnchor, constant: -6),
                inAppNotificationViewController.view.bottomAnchor.constraint(equalTo: topViewController.view.bottomAnchor, constant: -80),

            ])
            
        }
        else if inAppNotificationViewController.payload?.notificationDetails?.templateOrientation?.lowercased() == "fullscreen"  {
            inAppNotificationViewController.view.translatesAutoresizingMaskIntoConstraints = false
            topViewController.view.addSubview(inAppNotificationViewController.view)

            NSLayoutConstraint.activate([
                inAppNotificationViewController.view.topAnchor.constraint(equalTo: topViewController.view.topAnchor),
                inAppNotificationViewController.view.leadingAnchor.constraint(equalTo: topViewController.view.leadingAnchor),
                inAppNotificationViewController.view.trailingAnchor.constraint(equalTo: topViewController.view.trailingAnchor),
                inAppNotificationViewController.view.bottomAnchor.constraint(equalTo: topViewController.view.bottomAnchor)
            ])
            
        }
        
        inAppNotificationViewController.view.layer.cornerRadius = 10.0 // Adjust the radius to control corner roundness
        inAppNotificationViewController.view.layer.masksToBounds = true   // Notify the child view controller that it has been added
        inAppNotificationViewController.didMove(toParent: topViewController)
    }
}

@available(iOS 13.0, *)
extension HelperClass {
    public func hideInAppNotificationViewController() {
        // Assuming you have a reference to InAppNotificationViewController
        var inAppNotificationViewController: InAppNotificationViewController? = nil
        
        inAppNotificationViewController?.willMove(toParent: nil)
        inAppNotificationViewController?.view.removeFromSuperview()
        inAppNotificationViewController?.removeFromParent()
    }
    
}
