////
////  SwiftUIView.swift
////  templates
////
////  Created by Shivam on 31/07/23.
////
//
//import SwiftUI
//
//struct MainScreen: View {
//    @State private var isPreview1Presented = false
//    @State private var isPreview2Presented = false
//    @State private var isPreview3Presented = false
//    @State private var isPreview4Presented = false
//    @State private var isPreview5Presented = false
//    @State private var isPreview6Presented = false
//    @State private var isPreview7Presented = false
//    var body: some View {
//        NavigationView {
//            List {
//                Button(action: {
//                    isPreview1Presented = true
//                }) {
//                    Text("Preview 1")
//                }
//                Button(action: {
//                    isPreview2Presented = true
//                }) {
//                    Text("Preview 2")
//                }
//                Button(action: {
//                    isPreview3Presented = true
//                }) {
//                    Text("Preview 3")
//                }
//                Button(action: {
//                    isPreview4Presented = true
//                }) {
//                    Text("Preview 4")
//                }
//                Button(action: {
//                    isPreview5Presented = true
//                }) {
//                    Text("Preview 5")
//                }
//                Button(action: {
//                    isPreview6Presented = true
//                }) {
//                    Text("Preview 6")
//                }
//                Button(action: {
//                    isPreview7Presented = true
//                }) {
//                    Text("Preview 7")
//                }
//            }
//            .listStyle(GroupedListStyle())
//            .navigationBarTitle("Main Screen")
//        }
//        .sheet(isPresented: $isPreview1Presented) {
//            ContentView()
//        }
//        .sheet(isPresented: $isPreview2Presented) {
//            SwiftUIView1()
//        }
//        .sheet(isPresented: $isPreview3Presented) {
//            SwiftUIView2()
//        }
//        .sheet(isPresented: $isPreview4Presented) {
//            SwiftUIView3()
//        }
//        .sheet(isPresented: $isPreview5Presented) {
//            SwiftUIView4()
//        }
//        .sheet(isPresented: $isPreview6Presented) {
//            SwiftUIView5()
//        }
//        .sheet(isPresented: $isPreview7Presented) {
//          SwiftUIView6()
//        }
//    }
//}
//
//struct MainScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        MainScreen()
//    }
//}
//
import SwiftUI

//struct PreviewItem: Identifiable {
//    var id: Int
//}
//
//struct MainScreen: View {
//    @State private var selectedPreview: PreviewItem?
//
//    var body: some View {
//        NavigationView {
//            List {
//                Button(action: {
//                    selectedPreview = PreviewItem(id: 1)
//                }) {
//                    Text("Preview 1")
//                }
//                Button(action: {
//                    selectedPreview = PreviewItem(id: 2)
//                }) {
//                    Text("Preview 2")
//                }
//                Button(action: {
//                    selectedPreview = PreviewItem(id: 3)
//                }) {
//                    Text("Preview 3")
//                }
//                // Add more buttons for other previews if needed
//                Button(action: {
//                    selectedPreview = PreviewItem(id: 4)
//                }) {
//                    Text("Preview 4")
//                }
//                Button(action: {
//                    selectedPreview = PreviewItem(id: 5)
//                }) {
//                    Text("Preview 5")
//                }
//                Button(action: {
//                    selectedPreview = PreviewItem(id: 6)
//                }) {
//                    Text("Preview 6")
//                }
//                Button(action: {
//                    selectedPreview = PreviewItem(id: 7)
//                }) {
//                    Text("Preview 7")
//                }
//
//            }
//            .listStyle(GroupedListStyle())
//            .navigationBarTitle("Main Screen")
//            .popover(item: $selectedPreview) { preview in
//
//                switch preview.id {
//
//                    case 1:
//                        SwiftUIView1()
//                         padding()
//                        .background(Color.white)
//                        .cornerRadius(10)
//                        .shadow(radius: 5)
//                    case 2:
//                        SwiftUIView2()
//                    case 3:
//                        SwiftUIView3()
//                    case 4:
//                        SwiftUIView4()
//                    case 5:
//                        SwiftUIView5()
//                    case 6:
//                        ContentView()
//                    case 7:
//                        SwiftUIView6()
//
//                    default:
//                        EmptyView()
//                    }
//
//                }
//            }
//        }
//    }
//
//
import SwiftUI


struct PreviewItem: Identifiable {
    var id: Int

}

@available(iOS 13.0, *)
struct MainScreen: View {
    @State private var selectedPreview: PreviewItem?

  //  @available(iOS 16.0, *)
    var body: some View {
        NavigationView {
            List {
                Button(action: {
                    selectedPreview = PreviewItem(id: 1)
                }) {
                    Text("Preview 1")
                }
                Button(action: {
                    selectedPreview = PreviewItem(id: 2)
                }) {
                    Text("Preview 2")
                }
                Button(action: {
                    selectedPreview = PreviewItem(id: 3)
                }) {
                    Text("Preview 3")
                }
                // Add more buttons for other previews if needed
                Button(action: {
                    selectedPreview = PreviewItem(id: 4)
                }) {
                    Text("Preview 4")
                }
                Button(action: {
                    selectedPreview = PreviewItem(id: 5)
                }) {
                    Text("Preview 5")
                }
                Button(action: {
                    selectedPreview = PreviewItem(id: 6)
                }) {
                    Text("Preview 6")
                }
                Button(action: {
                    selectedPreview = PreviewItem(id: 7)
                }) {
                    Text("Preview 7")
                }

            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Main Screen")
        }
        .overlay( // Use overlay to show the selected preview
            ZStack {
                if let preview = selectedPreview {
                    switch preview.id {

                    case 1:
                        SwiftUIView1()
                            
                    case 2:
                        SwiftUIView2()
                            
                    case 3:
                        SwiftUIView3()
                            
                    case 4:
                        if #available(iOS 16.0, *) {
                            SwiftUIView4()
                        } else {
                            // Fallback on earlier versions
                        }
                            
                    case 5:
                        SwiftUIView5()
                           
                    case 6:
                        ContentView()
                            
                    case 7:
                        SwiftUIView6()
                            
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
    }
}




@available(iOS 14.0, *)
struct MainScreen_Previews: PreviewProvider {
   
    static var previews: some View {
        
            MainScreen()
        }
    }

