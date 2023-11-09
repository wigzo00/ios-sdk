//
//  SwiftUIView6.swift
//  templates
//
//  Created by Shivam on 31/07/23.
//

import SwiftUI

@available(iOS 13.0, *)
public struct Template7: View {
    @Binding public var isPresented: Bool
    
    public let title: String
    public let description: String
    public let imageUrl: URL
    @State private var downloadedImage: Image?
    public init(title: String, description: String,imageUrl: URL, isPresented: Binding<Bool>) {
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
        _isPresented = isPresented // Use _isPresented to initialize the Binding
    }
    public var body: some View {
        Rectangle()
            .foregroundColor(.black)
            .overlay(
                VStack {
                    ZStack(alignment: .topLeading) {
                        Image("Image2",bundle:.module)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        Spacer().padding(6)
                        
                        Button(action: {
                            isPresented = false // Dismiss the view when the button is tapped
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top:5, leading:280, bottom:0, trailing:5 ))
                        }
                        
                    }
                    Text(title)
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Text(description)
                        .foregroundColor(.white)
                        .font(.system(size: 13, weight: .bold))
                        .lineLimit(nil)
                        .lineSpacing(5)
                        .multilineTextAlignment(.center)
                        .padding()
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer().padding(3)
                    VStack {
                        
                        
                        Button(action: {
                            // Add action for the button here
                            print("OK button tapped!")
                        }) {
                            Text("OK")
                                .foregroundColor(.white)
                                .frame(minWidth: 0,maxWidth: .infinity)
                                .padding()
                            // .fontWeight(.bold)
                            //.background(Capsule().fill(Color.white))
                                .overlay(Capsule().stroke(Color.white, lineWidth: 4))
                                .cornerRadius(30.0)
                                .frame(width:215,height: 20)
                            
                            
                        }
                        .padding()
                        Spacer()
                        
                    }
                    Spacer()
                }
                
            )
            .frame(
                minWidth: 0,
                maxWidth: 310,
                minHeight: 0,
                maxHeight: 500,
                alignment: .top
            )
            .border(Color.gray, width: 1)
            .cornerRadius(2)
    }
    @available(iOS 13.0, *)
    
    struct Template7_Previews: PreviewProvider {
        @State static var isTemplate7Presented = true
        
        static var previews: some View {
            Template7(
                
                title: "Your Title",
                description: "Your Description",
                imageUrl: URL(string: "https://media.wigzo.com/dev_uploads/6Srd_EenR5qIIKuQvEZa0g/userimagegallery/0ee0fa26-cfa8-4655-83f1-83e8b1149e6f.jpg?_=2023-09-04T05:44:22.203Z")!,
                isPresented: $isTemplate7Presented)
            
        }
    }
}
