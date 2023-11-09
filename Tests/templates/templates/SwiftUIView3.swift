//
//  SwiftUIView3.swift
//  templates
//
//  Created by Shivam on 28/07/23.
//

import SwiftUI
struct SwiftUIView3: View {
    @available(iOS 13.0, *)
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
//
//
                
                    .fill(
                                    LinearGradient(
                                        colors: [Color(red: 0.98, green: 0.349, blue:0.349),
                                                 Color(red: 0.784, green: 0.26, blue: 0.26)],
                                        startPoint: .top,
                                        endPoint: .bottom)
                                )
                    .frame(width: 310, height: 300)
                    .cornerRadius(2)

                    .overlay(
                    HStack {
                        Spacer()
                        Button(action: {
                            print("X button tapped!")
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(Color(hex: "#ffffff"))
                                .opacity(0.6)
                                
                            
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                .padding(5)
                        
                            
                        }
                    }
                    .padding(EdgeInsets(top: 15, leading: 10, bottom: 0, trailing: 10))
                    )
                    
                

                ZStack(alignment: .top) {
                    VStack(spacing: 35) {
                        Text("Title")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .top)



                        Text("Lorem ipsum dolor sit amet, con- sectetur adipiscing elit. Ut ante mi, eleifend id dignissim ac, imperdiet ut tortor. Duis blandit, ipsum dictum lobortis dignissim, ex dolor consectetur neque, at tincidunt nibh mauris a justo.")
                            .foregroundColor(.white)
                            .font(.system(size: 13, weight: .bold))
                            .multilineTextAlignment(.center)
                            .frame(minWidth: 130,maxWidth:200)

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
                                .padding()


                    }

                               )

                               }


                    .padding(.top, 35)



                }



            }


        }
    }
}



@available(iOS 13.0, *)
struct SwiftUIView3_Previews: PreviewProvider {
    //@available(iOS 13.0, *)
    static var previews: some View {
        SwiftUIView3()
    }
}
