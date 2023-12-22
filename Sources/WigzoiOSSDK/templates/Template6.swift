//
//  SwiftUIView5.swift
//  templates
//
//  Created by Shivam on 31/07/23.
//

import SwiftUI

//@available(iOS 13.0, *)
@available(iOS 13.0, *)
public struct Template6: View {
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
    //  @available(iOS 16.0, *)
    public var body: some View {
        Rectangle()
            .foregroundColor(.white)
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
                                .padding(EdgeInsets(top:15, leading:280, bottom:0, trailing:5 ))
                        }
                        
                    }
                    Text(title)
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .regular))
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Text(description)
                        .foregroundColor(.black)
                        .font(.system(size: 13, weight: .light))
                        .lineLimit(nil)
                        .lineSpacing(5)
                        .multilineTextAlignment(.center)
                        .padding()
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer().padding(6)
                    VStack {
                        
                        Rectangle() // Separator line
                            .frame(width:180, height:2)
                            .foregroundColor(Color.gray)
                        Button(action: {
                            // Add action for the button here
                            print("OK button tapped!")
                        }) {
                            Text("OK")
                                .foregroundColor(.green)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                            //.fontWeight(.bold)
                                .frame(width:120, height: 40) // Adjust width to bring buttons closer
                            // .padding()
                            
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
}

@available(iOS 13.0, *)
struct Template6_Previews: PreviewProvider {
    
    @State static var isTemplate6Presented = true
    
    static var previews: some View {
        Template6(
            
            title: "Your Title",
            description: "Your Description",
            imageUrl: URL(string: "https://media.wigzo.com/dev_uploads/6Srd_EenR5qIIKuQvEZa0g/userimagegallery/0ee0fa26-cfa8-4655-83f1-83e8b1149e6f.jpg?_=2023-09-04T05:44:22.203Z")!,
            isPresented: $isTemplate6Presented)
        
    }
}
