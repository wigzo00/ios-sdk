import SwiftUI
struct SwiftUIView1: View {
    
    @available(iOS 13.0, *)
    var body: some View {
        Rectangle()
            .foregroundColor(.black)
            .frame(width: 310, height: 500)
            .overlay(
                    VStack() {
                        HStack {
                                          Spacer()
                                          Button(action: {
                                              print("X button tapped!")
                                          }) {
                                              Image(systemName: "xmark")
                                                  .foregroundColor(Color(hex: "#d33e74"))

                                                  .frame(width: 40, height: 30)
                                                  .padding(10)
                                          }
                     
                        }
                                      .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                        
                        Text("Title")
                        
                            .foregroundColor(Color(hex: "#d33e74"))
                            .font(.system(size: 18,weight: .bold))
                            .lineLimit(nil)
                            .lineSpacing(5)
                            .multilineTextAlignment(.center)
                            .padding(.top, 50)
                        Spacer()
                        GeometryReader{geometry in
                            ZStack{
                                Color.black
                                
                                
                                VStack() {
                                    Spacer()
                                    
                                    Text("Lorem ipsum dolor sit amet, consecte- tur adipiscing elit. Ut ante mi, eleifend id dignissim ac, imperdiet ut tortor. Duis blandit, ipsum dictum lobortis dignissim, ex dolor consectetur neque, at tincidunt nibh mauris a justo.")
                                        .foregroundColor(Color(hex: "#ffffff"))
                                    
                                        .font(.system(size: 15, weight: .bold))
                                        .lineLimit(nil)
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

struct SwiftUIView1_Previews: PreviewProvider {
    @available(iOS 13.0, *)
    static var previews: some View {
        SwiftUIView1()
    }
}

