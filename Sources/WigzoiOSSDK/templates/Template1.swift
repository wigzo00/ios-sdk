//
//  SwiftUIView3.swift
//  templates
//
//  Created by Shivam on 22/07/23.
//

import SwiftUI

@available(iOS 13.0, *)
@available(iOS 13.0, *)
public struct Template1: View {
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
                Rectangle()
                    .foregroundColor(Color.white.opacity(0.8))
                    .overlay(
                        VStack {
                            ZStack(alignment: .topLeading) {
                                if let downloadedImage = downloadedImage {
                                    downloadedImage
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                }
                                
                                Spacer().padding(6)
                                
                                Button(action: {
                                    isPresented = false // Dismiss the view when the button is tapped
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.white)
                                        .padding(EdgeInsets(top:5, leading: 280, bottom: 5, trailing: 5))
                                    
                                }
                                .padding(5)
                            }
                            
                            Text(title)
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .regular))
                                .padding()
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(5)
                                .padding(.top,20)
                            
                            Text(description)
                                .foregroundColor(.black)
                                .font(.system(size: 13, weight: .light))
                                .lineLimit(nil)
                                .lineSpacing(5)
                                .multilineTextAlignment(.center)
                                .padding()
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(5)
                            
                            Spacer().padding(6)
                            HStack{
                                Button(action: {
                                    print("Button tapped!")
                                }, label: {
                                    Text("Cancel")
                                        .foregroundColor(.gray)
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .padding()
                                        .background(Capsule().fill(Color.white))
                                        .overlay(Capsule().stroke(Color.gray, lineWidth: 2))
                                        .cornerRadius(30.0)
                                        .frame(width: 120, height:5)
                                        .padding()
                                        .padding(.bottom,5)
                                })
                                
                                
                                Spacer()
                                
                                Button(action: {
                                    // Add action for the button here
                                    print("Button tapped!")
                                }, label: {
                                    Text("OK")
                                        .foregroundColor(.green)
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .padding()
                                        .background(Capsule().fill(Color.white))
                                        .overlay(Capsule().stroke(Color.gray, lineWidth: 2))
                                        .cornerRadius(30.0)
                                        .frame(width:120, height:5)
                                        .padding(.bottom,5)
                                        
                                        
                                })
                                
                                Spacer()
                            }
                            Spacer()
                            Spacer(minLength:30)
                        }
                    )
                    .frame(
                        minWidth: 0,
                        maxWidth: 320,
                        minHeight: 0,
                        maxHeight: 490,
                        alignment: .top
                    )
                    .border(Color.gray, width: 1)
                    .cornerRadius(2)
                    .onAppear {
                        loadImage()
                    }
            
    }

    private func loadImage() {
        URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
            if let data = data, let uiImage = UIImage(data: data) {
                downloadedImage = Image(uiImage: uiImage)
            }
        }.resume()
    }
}

@available(iOS 13.0, *)
struct Template1_Previews: PreviewProvider {
    @State static var isTemplate1Presented = true
    static var previews: some View

    {
        Template1(
            
            
            title: "Your Title",
                    description: "Your Description",
                    imageUrl: URL(string: "https://media.wigzo.com/dev_uploads/6Srd_EenR5qIIKuQvEZa0g/userimagegallery/0ee0fa26-cfa8-4655-83f1-83e8b1149e6f.jpg?_=2023-09-04T05:44:22.203Z")!,
            isPresented: $isTemplate1Presented
                )    }
}

