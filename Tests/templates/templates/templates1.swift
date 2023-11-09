
//  ContentView.swift
//  templates
//
//  Created by Shivam on 24/07/23.




import SwiftUI



struct ContentView:View {

    @available(iOS 13.0, *)
    var body:some View {
        Rectangle()
            .foregroundColor(.white)

            .overlay(
                VStack()
                {
                    ZStack(alignment: .topLeading){
                        Image("Image")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        Spacer().padding(6)

                        Text("X")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .topTrailing)
                            .font(.system(size: 20))
                            .padding(10)
                    }
                    Text("Title")
                        .foregroundColor(.black)
                        .font(.system(size:16, weight: .regular))

                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ante mi, eleifend id dignis- sim ac, imperdiet ut tortor. Duis blandit, ipsum dictum lobortis dignissim, ex dolor consectetur neque, at tincidunt nibh mauri.")
                        .foregroundColor(.black)
                        .font(.system(size: 13,weight: .light))
                        .lineLimit(nil)
                        .lineSpacing(5)
                        .multilineTextAlignment(.center)
                        .padding()
                        .fixedSize(horizontal: false, vertical: true)

                    Spacer().padding(6)

                    Button(action: {
                        print("Button tapped!")

                    }, label: {
                        Text("OK")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0,maxWidth: .infinity)
                            .padding()
                            .background(Capsule().fill(Color.white))
                            .overlay(Capsule().stroke(Color.gray, lineWidth: 2))
                            .cornerRadius(20.0)
                            .frame(width:215,height: 20)

                    })
                    Spacer()
                        .padding(13)


                    Button(action: {
                        // Add action for the button here
                        print("Button tapped!")

                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0,maxWidth: .infinity)

                            .padding()
                            .background(Capsule().fill(Color.white))
                            .overlay(Capsule().stroke(Color.gray, lineWidth: 2))
                            .cornerRadius(20.0)
                            .frame(width:215,height: 20)
                    })

                    Spacer()
                        .padding()

                }
            )
            .frame(
                minWidth: 0,
                maxWidth: 310,
                minHeight: 0,
                maxHeight: 550,
                alignment: .top
            )
            .border(Color.gray, width: 1)
            .cornerRadius(2)
    }







        struct ContentView_Previews: PreviewProvider {
            @available(iOS 13.0, *)
            static var previews: some View {

                    
        
                ContentView()





                }



            }
        }



