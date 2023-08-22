//
//  Modal.swift
//  demo_inApp
//
//  Created by Shivam on 18/08/23.
//

import SwiftUI


public struct Template1View: View {
    
    var title: String
    var bodyText: String

   public  var body: some View {
        VStack {
            Text(title)
                .font(.title)
            Text(bodyText)
                .font(.body)
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}

