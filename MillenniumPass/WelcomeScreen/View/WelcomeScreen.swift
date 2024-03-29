//
//  WelcomeScreen.swift
//  MillenniumPass
//
//  Created by Szymon Szysz on 08/10/2021.
//

import SwiftUI

struct WelcomeScreen: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(hex: "B40046"), Color(hex: "B40046")]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.vertical)
            .overlay(
                VStack {
//                    Text("Witamy w Millennium Team")
//                        .font(.system(.largeTitle, design: .rounded))
//                        .multilineTextAlignment(.center)
//                        .foregroundColor(.white)
//                        .padding(.top, 100)

                    Spacer()

                    VStack {
                        Image("mille_icon")
                        Text("Please check your mailbox for the activation link!")
                            .font(.system(.headline, design: .rounded))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                    }

                    Spacer()
                    Text("Copyright © Bank Millennium SA")
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.bottom, 30)
                }
                .padding([.top, .horizontal])
                .padding(.horizontal)
            )
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}

