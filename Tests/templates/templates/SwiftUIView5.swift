//
//  SwiftUIView5.swift
//  templates
//
//  Created by Shivam on 31/07/23.
//

import SwiftUI

//@available(iOS 13.0, *)
@available(iOS 13.0, *)
struct SwiftUIView5: View {
  //  @available(iOS 16.0, *)
    var body: some View {
        Rectangle()
            .foregroundColor(.white)
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
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .regular))
                        .multilineTextAlignment(.center)
                        .padding()

                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ante mi, eleifend id dignis- sim ac, imperdiet ut tortor. Duis blandit, ipsum dictum lobortis dignissim, ex dolor consectetur neque, at tincidunt nibh mauri.")
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
struct SwiftUIView5_Previews: PreviewProvider {
   
    static var previews: some View {
        if #available(iOS 16.0, *) {
            SwiftUIView5()
        } else {
            // Fallback on earlier versions
        }
    }
}
