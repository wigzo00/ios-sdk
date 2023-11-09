//
//  templatesApp.swift
//  templates
//
//  Created by Shivam on 24/07/23.
//
//
//import SwiftUI
//
//@main
//struct templatesApp: App {
//    var body: some Scene {
//        WindowGroup {
//            MainScreen()
//        }
//    }
//}
//import WigzoiOSSDK
import SwiftUI

@available(iOS 14.0, *)
struct templatesApp : App {
    @available(iOS 14.0, *)
    var body : some Scene {
        WindowGroup{
            MainScreen()
        }
    
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    

   }



class AppDelegate : NSObject, UIApplicationDelegate {
    func application(_ application : UIApplication, didFinishLaunchingWithOptions launchOptions : [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        try! Wigzo.initialize(orgToken: "MZ-bpDDYTIeem9nz8P4Icg")
        return true
    }
}

