//
//  SwiftUIView3.swift
//  templates
//
//  Created by Shivam on 28/07/23.
//

import SwiftUI
@available(iOS 13.0, *)
public struct Template2: View {
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
        Rectangle()
            .foregroundColor(.black)
            .frame(width: 310, height: 412)
            .overlay(
                VStack() {
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
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                    
                    Text(title)
                    
                        .foregroundColor(Color(hex: "#d33e74"))
                        .font(.system(size: 18,weight: .bold))
                        .lineLimit(5)
                        .lineSpacing(5)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding(.top, 50)
                    Spacer()
                    GeometryReader{geometry in
                        ZStack{
                            Color.black
                            
                            
                            VStack() {
                                Spacer()
                                
                                Text(description)
                                    .foregroundColor(Color(hex: "#ffffff"))
                                
                                    .font(.system(size: 15, weight: .bold))
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineLimit(5)
                                    .lineSpacing(5)
                                    .multilineTextAlignment(.center)
                                // .padding()
                                Spacer()
                            }
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                    .padding(30)
                    LinearGradientButton(title: "OK", gradientColors: [Color(hex: "#d33e74"), Color(hex: "#6649bd")])
                        .frame(width: 230, height: 50)
                        .padding()
                    
                    Spacer()
                }
            )
        
    }
    
}
@available(iOS 13.0, *)

@available(iOS 13.0, *)
struct LinearGradientButton: View {
    @available(iOS 13.0, *)
    let title: String
    let gradientColors: [Color]
    
    var body: some View {
        Button(action: {
            // Add action for the button here
            print("Button tapped!")
        }) {
            Text(title)
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(70.0)
                .frame(width: 230,height: 48)
        }
    }
}

@available(iOS 13.0, *)
extension Color {
    init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        self.init(
            red: Double((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: Double((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: Double(rgbValue & 0x0000FF) / 255.0
            
        )
        
    }
}

@available(iOS 13.0, *)
struct Template2_Previews: PreviewProvider {
    @available(iOS 13.0, *)
    @State static var isTemplate2Presented = true
    static var previews: some View {
        Template2(title: "Your Title",
                  description: "Your Description",
                  imageUrl: URL(string: "https://media.wigzo.com/dev_uploads/6Srd_EenR5qIIKuQvEZa0g/userimagegallery/0ee0fa26-cfa8-4655-83f1-83e8b1149e6f.jpg?_=2023-09-04T05:44:22.203Z")!,
          isPresented: $isTemplate2Presented)
    }
}

