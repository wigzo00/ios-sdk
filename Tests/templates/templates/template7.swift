//
//  SwiftUIView6.swift
//  templates
//
//  Created by Shivam on 31/07/23.
//

import SwiftUI

@available(iOS 13.0, *)
struct template7: View {
    //@available(iOS 16.0, *)
    var body: some View {
        Rectangle()
            .foregroundColor(.black)
            .overlay(
                VStack {
                    ZStack(alignment: .topLeading) {
                        Image("Image")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        Spacer().padding(6)
                        
                        Text("X")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment:.trailing)
                            .font(.system(size: 20))
                            .padding(.top,10) // Increase distance from the top
                            .padding(.trailing,-2)
                            .padding(15)
                        
                    }
                    
                    
                    Text("Title")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ante mi, eleifend id dignis- sim ac, imperdiet ut tortor. Duis blandit, ipsum dictum lobortis dignissim, ex dolor consectetur neque, at tincidunt nibh mauri.")
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
    
    struct template7_Previews: PreviewProvider {
        @available(iOS 13.0, *)
        static var previews: some View {
            template7()
        }
    }
}
