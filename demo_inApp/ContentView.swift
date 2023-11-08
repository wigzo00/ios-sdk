//
//  ContentView.swift
//  demo_inApp
//
//  Created by Shivam on 08/08/23.
//

//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            VStack(alignment: .leading) {
//                       Button("Show details") {
//
//                       }
//
////
//                       }
//                   }
//
//            }
//        }
//
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//import SwiftUI
//import UserNotifications
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            VStack(alignment: .leading) {
//                Button("Show details") {
//                    requestNotificationPermission() // Request permission before sending notification
//                    sendNotification()
//                }
//            }
//        }
//    }
//
//    // Request notification permission
//    private func requestNotificationPermission() {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
//            if granted {
//                print("Notification permission granted")
//            } else {
//                print("Notification permission denied")
//            }
//        }
//    }
//
//    // Send a sample notification
//    private func sendNotification() {
//        let content = UNMutableNotificationContent()
//        content.title = "Notification Title"
//        content.body = "This is a sample notification."
//        content.sound = UNNotificationSound.default
//
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print("Error sending notification:", error.localizedDescription)
//            } else {
//                print("Notification sent successfully")
//            }
//        }
//    }
//}



import SwiftUI
import Firebase
import UserNotifications
import WigzoiOSSDK



struct PreviewItem: Identifiable {
    var id: Int

}


struct ContentView: View {
    
    @State private var selectedPreview: PreviewItem?
    @State private var isTemplate1Presented = false
    @State private var isNavigationActive = false
    @State private var isUIKitViewControllerPresented = false

    
    
    var body: some View {
        //        VStack {
        //            VStack(alignment: .leading) {
        //                Button("show details") {
        //
        VStack{
            NavigationView{
                List {
                    
//                    Button(action: {
//                        
////                        selectedPreview = PreviewItem(id: 001)
//                        requestNotificationPermission()
//                        generateFCMTokenAndSendNotification()
//                        isUIKitViewControllerPresented = true
//                    }) {
//                        Text("Template 1")
//                    }.sheet(isPresented: $isUIKitViewControllerPresented) {
//                        UIKitViewControllerWrapper()
//                    }
                    
                    
                    
                    Button(action: {
                        
//                        selectedPreview = PreviewItem(id: 001)
                        requestNotificationPermission()
                        generateFCMTokenAndSendNotification()
                        isTemplate1Presented = true
                    }) {
                        Text("Template 1")
                    }
                    Button(action: {
                        selectedPreview = PreviewItem(id: 002)
                        requestNotificationPermission()
                        generateFCMTokenAndSendNotification()
                    }) {
                        Text("Preview 2")
                    }
                    Button(action: {
                        selectedPreview = PreviewItem(id: 003)
                        requestNotificationPermission()
                        generateFCMTokenAndSendNotification()
                    }) {
                        Text("Preview 3")
                    }
                    // Add more buttons for other previews if needed
                    Button(action: {
                        selectedPreview = PreviewItem(id: 004)
                        requestNotificationPermission()
                        generateFCMTokenAndSendNotification()
                    }) {
                        Text("Preview 4")
                    }
                    Button(action: {
                        selectedPreview = PreviewItem(id: 005)
                        requestNotificationPermission()
                        generateFCMTokenAndSendNotification()
                    }) {
                        Text("Preview 5")
                    }
                    Button(action: {
                        selectedPreview = PreviewItem(id: 006)
                        requestNotificationPermission()
                        generateFCMTokenAndSendNotification()
                    }) {
                        Text("Preview 6")
                    }
                    Button(action: {
                        selectedPreview = PreviewItem(id: 007)
                        requestNotificationPermission()
                        generateFCMTokenAndSendNotification()
                    }) {
                        Text("Preview 7")
                    }
                    
                    
//                    NavigationLink(destination: DestinationView()) {
//                        Button(action:{
//                            isNavigationActive = true
//                        }){
//                            Text("Navigate to Destination View")
//                                .foregroundColor(.black)
//                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.green) .frame(width: 250, height: 50))
//                        }
//                        .padding()
//                        //  Spacer()
//                    }
                    
                }
                .listStyle(GroupedListStyle())
                .navigationBarTitle("Main Screen")
                Button(action: {
                    isNavigationActive = true
                }) {
                    Text("Navigate to Destination View")
                        .foregroundColor(.black)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.green).frame(width: 250, height: 50))
                }
                .padding()
            }
            .overlay(
                ZStack {
                    
                    if let preview = selectedPreview {
                        switch preview.id {
                            
                        case 1:
                            Template1( title: "Dynamic Title", description: "Dynamic Description", imageUrl: URL(string: "image_url")!, isPresented: $isTemplate1Presented )
                        case 2:
                            Template2( title: "Dynamic Title", description: "Dynamic Description", imageUrl: URL(string: "image_url")!, isPresented: $isTemplate1Presented )
                            
                        case 3:
                            Template3( title: "Dynamic Title", description: "Dynamic Description", imageUrl: URL(string: "image_url")!, isPresented: $isTemplate1Presented )
                            
                        case 4:
                            Template4( title: "Dynamic Title", description: "Dynamic Description", imageUrl: URL(string: "image_url")!, isPresented: $isTemplate1Presented )
                            
                        case 5:
                            Template5( title: "Dynamic Title", description: "Dynamic Description", imageUrl: URL(string: "image_url")!, isPresented: $isTemplate1Presented )
                            
                        case 6:
                            Template6( title: "Dynamic Title", description: "Dynamic Description", imageUrl: URL(string: "image_url")!, isPresented: $isTemplate1Presented )
                            
                        case 7:
                            Template7( title: "Dynamic Title", description: "Dynamic Description", imageUrl: URL(string: "image_url")!, isPresented: $isTemplate1Presented )
                        
                        default:
                            EmptyView()
                        }
                    }
                }
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        selectedPreview = nil // Dismiss the preview when tapped outside
                    }
            )
            //        .onAppear{
            //
            //
            //            requestNotificationPermission()
            //            generateFCMTokenAndSendNotification()
            //        }
            
            
        }
        
    }
    
    
    
    
    func openCustomView() {
        print("root vc === \(UIApplication.shared.windows)")
    }
    
    
    public func requestNotificationPermission() {
        //        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
        //            if granted {
        //                print("Notification permission granted")
        //                DispatchQueue.main.async {
        //                    UIApplication.shared.registerForRemoteNotifications()
        //
        //
        //                }
        //            } else {
        //                print("Notification permission denied")
        //            }
        //        }
    }
    
    public  func generateFCMTokenAndSendNotification() {
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token:", error)
            } else if let token = token {
                print("FCM registration token:", token)
                sendNotificationToFCMToken(token)
            }
        }
    }
    
    public func sendNotificationToFCMToken(_ fcmToken: String) {
        // Use your FCM token to send a notification to the specific device
        // This could involve a backend API that sends the notification to FCM
        // with the target FCM token and notification payload
    }
    //    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    //        print("Firebase registration token: \(String(describing: fcmToken))")
    //
    //        let dataDict: [String: String] = ["token": fcmToken ?? ""]
    //        NotificationCenter.default.post(
    //            name: Notification.Name("FCMToken"),
    //            object: nil,
    //            userInfo: dataDict
    //        )
    //        Messaging.messaging().token { token, error in
    //                    // Check for error. Otherwise do what you will with token here
    //                    if error != nil {
    //                    } else if let result = token {
    //                      //  FDUtility.debugPrint("Firebase token: \(unwrap(str: result))")
    //                        print(result)
    //                        //UIPasteboard.general.string = unwrap(str: token)
    //                    }
    //                }
    //        // TODO: If necessary send token to application server.
    //        // Note: This callback is fired at each app startup and whenever a new token is generated.
    //    }
    //
    
    //  }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                
                    //Template1(title: "Dynamic Title", description: "Dynamic Description")
                    
                }
        }
        
    
    
}
