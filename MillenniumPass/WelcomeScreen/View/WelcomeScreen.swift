//
//  WelcomeScreen.swift
//  MillenniumPass
//
//  Created by Szymon Szysz on 08/10/2021.
//

import SwiftUI

struct WelcomeScreen: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.white, Color(.systemPink)]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.vertical)
            .overlay(
                VStack {
                    Text("Witamy w Millennium Team")
                        .font(.system(.largeTitle, design: .rounded))
                        .multilineTextAlignment(.center)
                    Image("mille_icon")
                    Text("Aby przejść dalej potrzebujesz linka od swojego przełożonego")
                        .font(.system(.headline, design: .rounded))
                        .multilineTextAlignment(.center)
                    Spacer()
                    Text("Copyright © Bank Millennium SA")
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.white)
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

