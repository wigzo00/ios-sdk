    //
    //  SwiftUIView2.swift
    //  templates
    //
    //  Created by Shivam on 27/07/23.
    //

    import SwiftUI

    //struct SwiftUIView2: View {
    //    var body: some View {
    //        VStack{
    //            ZStack(){
    //                Image("Image1")
    //                    .resizable()
    //                //.scaledToFit()
    //                    .padding(30)
    //
    //                    .scaledToFit()
    //                    .offset()
    //
    //                ZStack(alignment: .top){
    //
    //                    Rectangle()
    //
    //
    //                        .foregroundColor(Color(hex: "#c3ede7"))
    //                        .overlay(Rectangle().stroke(Color.white, lineWidth: 0))
    //
    //                        .frame(width: 280,height: 270)
    //                        .opacity(0.4)
    //                        .padding()
    //
    //                    Text("Title")
    //                        .foregroundColor(.white)
    //                        .font(.system(size: 18, weight: .bold))
    //                        .padding(.top, 35)
    //                        .frame(maxWidth: .infinity, alignment: .top)
    //
    //
    //                    VStack() {
    //                                            Text("Lorem ipsum dolor sit amet, con- sectetur adipiscing elit. Ut ante mi, eleifend id dignissim ac, imperdiet ut tortor. Duis blandit, ipsum dictum lobortis dignissim, ex dolor consectetur neque, at tincidunt nibh mauris a justo.")
    //                                                .foregroundColor(.white)
    //                                                .font(.system(size: 15, weight: .regular))
    //                                                .multilineTextAlignment(.center)
    //                                                .lineSpacing(5)
    //                                                .padding()
    //                                                .frame(minWidth: 135)
    //
    //                                            // Add more text views with spacing if needed
    //
    //                                        }
    //                                        .padding(.top, 70)
    //                                        .padding()
    //
    //
    //                    }
    //                }
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //            }
    //        }
    //
    //
    //    struct SwiftUIView2_Previews: PreviewProvider {
    //        static var previews: some View {
    //            SwiftUIView2()
    //        }
    //    }
    //}
    //
    import SwiftUI

    //struct SwiftUIView2: View {
    //    var body: some View {
    //        VStack {
    //            ZStack {
    //                Image("Image1")
    //                    .resizable()
    //                    .padding(30)
    //                    .scaledToFit()
    //
    //                ZStack(alignment: .top) {
    //                    Rectangle()
    //                        .foregroundColor(Color(hex: "#c3ede7"))
    //                        .overlay(Rectangle().stroke(Color.white, lineWidth: 0))
    //                        .frame(width: 280, height: 350)
    //                        .opacity(0.4)
    //                        .padding(.top, 20) // Add padding to shift the rectangle higher
    //
    //                    Text("Title")
    //                        .foregroundColor(.white)
    //                        .font(.system(size: 18, weight: .bold))
    //                        .padding(.top, 35)
    //                        .frame(maxWidth: .infinity, alignment: .top)
    //
    //                    Text("Lorem ipsum dolor sit amet, con- sectetur adipiscing elit. Ut ante mi, eleifend id dignissim ac, imperdiet ut tortor. Duis blandit, ipsum dictum lobortis dignissim, ex dolor consectetur neque, at tincidunt nibh mauris a justo.")
    //                        .foregroundColor(.white)
    //                        .font(.system(size: 14))
    //                        .multilineTextAlignment(.center)
    //                        .frame(minWidth: 130)
    //                        .padding(.top, 70)
    //                }
    //            }
    //        }
    //    }
    //}
    //
    //struct SwiftUIView2_Previews: PreviewProvider {
    //    static var previews: some View {
    //        SwiftUIView2()
    //    }
    //}
    import SwiftUI

    struct SwiftUIView2: View {
        @available(iOS 13.0, *)
        var body: some View {
            VStack {
                ZStack {
                    Image("Image1")
                        .resizable()
                        .padding(30)
                        .scaledToFit()
                        .overlay(
                        HStack {
                            Spacer()
                            Button(action: {
                                print("X button tapped!")
                            }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(Color(hex: "#ffffff"))
                                    
                                
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                    .padding(5)
                            
                                
                            }
                        }
                        .padding(EdgeInsets(top: 40, leading: 10, bottom: 0, trailing: 40))
                        )
                    

                    ZStack(alignment: .top) {

                        Rectangle()
                            .foregroundColor(Color(hex: "#c3ede7"))
                            .overlay(Rectangle().stroke(Color.white, lineWidth: 0))
                            .frame(width: 310, height:300)
                            .opacity(0.4)
                            .padding(.top, 20) // Add padding to shift the rectangle higher
                            .offset(y:-25)




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
                                    .background(Color(hex: "#42c6b3"))
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

    struct SwiftUIView2_Previews: PreviewProvider {
        @available(iOS 13.0, *)
        static var previews: some View {
            SwiftUIView2()
        }
    }
