

//
//  SwiftUIView3.swift
//  templates
//  Created by Shivam on 27/07/23.
import SwiftUI

@available(iOS 13.0, *)
public struct Template3: View {
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
    
    @available(iOS 13.0, *)
    public var body: some View {
    
        VStack {
            ZStack {
                Rectangle()
               // .frame(width: 412, height: 450)
                .foregroundColor(.white).hidden()
                Image("Image1",bundle:.module)
                    .resizable()
                    .padding(30)
                    .frame(width: 412, height: 450)
                    .scaledToFit()
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
                                    .padding()
                                  
                            }
                        }

                            .padding(EdgeInsets(top:-5, leading: 5, bottom:350, trailing: 15))
                            .foregroundColor(.clear)
                    )
                
                ZStack(alignment: .top) {
                    Rectangle()
                        .foregroundColor(Color(hex: "#c3ede7"))
                        .overlay(Rectangle().stroke(Color.white, lineWidth: 0))
                        .frame(width: 310, height:300)
                        .opacity(0.4)
                        .padding(.top, 35) // Add padding to shift the rectangle higher
                        .offset(y:-25)
                    
                    VStack(spacing: 35) {
                        Text(title)
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold))
                            .frame(maxWidth: 200, alignment: .top)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(5)
                            .padding(.top,-10)
                           
                        
                        Text(description)
                            .foregroundColor(.white)
                            .font(.system(size: 13, weight: .bold))
                            .multilineTextAlignment(.center)
                            .frame(minWidth: 130,maxWidth:200)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(5)
                            .padding(.top,10)
                        
                    }
                    .padding(.top, 50)
                    .padding()
                    .background(Color.clear) // Set the background to clear
                    .edgesIgnoringSafeArea(.all)
                    Button(action: {
                        print("Button tapped!")
                        
                    }, label: {
                        Text("OK")
                            .foregroundColor(.white)
                            .font(.system(size: 15,weight: .bold))
                            .frame(minWidth: 0,maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "#42c6b3"))
                            .frame(width:310,height: 20)
                            .padding()
                        
                    }
                    
                           
                    )
                    .padding(.init(top:280, leading: 0, bottom: 0, trailing: 0))
                    
                }
                
            }
        }
    }
}

@available(iOS 13.0, *)
struct Template3_Previews: PreviewProvider {
   
    @State static var isTemplate3Presented = true

    @available(iOS 13.0, *)
    static var previews: some View {
        
        Template3(
            
            
            title: "Your Title",
                    description: "Your Description",
                    imageUrl: URL(string: "https://media.wigzo.com/dev_uploads/6Srd_EenR5qIIKuQvEZa0g/userimagegallery/0ee0fa26-cfa8-4655-83f1-83e8b1149e6f.jpg?_=2023-09-04T05:44:22.203Z")!,
            isPresented: $isTemplate3Presented
                )    
    }
}
