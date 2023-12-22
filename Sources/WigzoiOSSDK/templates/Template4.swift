//
//  SwiftUIView3.swift
//  templates
//
//  Created by Shivam on 28/07/23.
//

import SwiftUI
@available(iOS 13.0, *)
public struct Template4: View {
    @Binding public var isPresented: Bool
    
    public let title: String
    public let description: String
    public let imageUrl: URL
    @State private var downloadedImage: Image?
    
    public init(title: String, description: String, imageUrl: URL, isPresented: Binding<Bool>) {
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
        _isPresented = isPresented // Use _isPresented to initialize the Binding
    }
    @available(iOS 13.0, *)
    public var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [Color(red: 0.98, green: 0.349, blue:0.349),
                                     Color(red: 0.784, green: 0.26, blue: 0.26)],
                            startPoint: .top,
                            endPoint: .bottom)
                    )
                    .frame(width: 310, height: 350)
                    .cornerRadius(2)
                
                    .overlay(
                        HStack {
                            Spacer()
                            Button(action: {
                                isPresented = false // Dismiss the view when the button is tapped
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                            }
                        }
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 290, trailing: 5))
                    )
                
                ZStack(alignment: .top) {
                    VStack(spacing: 35) {
                        Text(title)
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .top)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(5)
                            .padding(.top,51)
                        Text(description)
                            .foregroundColor(.white)
                            .font(.system(size: 13, weight: .bold))
                            .multilineTextAlignment(.center)
                            .frame(minWidth: 130,maxWidth:200)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(5)
                            .padding(.top,51)
                        Button(action: {
                            print("Button tapped!")
                            
                        }, label: {
                            Text("OK")
                                .foregroundColor(.white)
                                .font(.system(size: 15,weight: .bold))
                                .frame(minWidth: 0,maxWidth: .infinity)
                                .padding()
                                .background(Color(hex: "#ba3e3e"))
                                .frame(width:310,height: 20)
                                .padding(EdgeInsets(top:51, leading: 0, bottom:0, trailing:0))
                            
                        }
                               
                        )
                        
                    }
                    .padding(.top, 51)
                    
                }
                
            }
        }
    }
}
@available(iOS 13.0, *)
struct Template4_Previews: PreviewProvider {
    //@available(iOS 13.0, *)
    @State static var isTemplate4Presented = true
    
    static var previews: some View {
        Template4(
            
            title: "Your Title",
            description: "Your Description",
            imageUrl: URL(string: "https://media.wigzo.com/dev_uploads/6Srd_EenR5qIIKuQvEZa0g/userimagegallery/0ee0fa26-cfa8-4655-83f1-83e8b1149e6f.jpg?_=2023-09-04T05:44:22.203Z")!,
            isPresented: $isTemplate4Presented)
        
    }
}
