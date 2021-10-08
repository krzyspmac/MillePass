//
//  TextMessageView.swift
//  MillenniumPass
//
//  Created by Szymon Szysz on 08/10/2021.
//

import SwiftUI

struct TextMessageView: View {
    @State var smsString: String = ""
    @State private var showingAlert = false
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.white, Color(.magenta)]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.vertical)
            .overlay(
                VStack {
                    Text("Poczekaj na wiadomość SMS z kodem PIN, aby aktywować aplikacje")
                        .font(.system(.largeTitle, design: .rounded))
                        .multilineTextAlignment(.center)
                    TextField("Kod sms", text: $smsString)
                        .font(.system(.headline, design: .rounded))
                        .multilineTextAlignment(.center)
                        .padding(20)
                    Spacer()
                    Button("Autoryzuj".uppercased()) {
                        if smsString == "1111" {
                            print("You shall pass jeden")
                            UserManager.shared.loggedInUser = User.fromIdentifier(1)
                        } else if smsString == "2222" {
                            print("You shall pass dwa")
                            UserManager.shared.loggedInUser = User.fromIdentifier(2)
                        } else {
                            showingAlert = true
                        }
                    }
                    .foregroundColor(.black)
                    Spacer()
                    Text("Copyright © Bank Millennium SA")
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.white)

                }
                .padding([.top, .horizontal])
                .padding(.horizontal)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Noooooo!"), message: Text("You shall not pass !!!"), dismissButton: .cancel())
                }
            )
    }
}

struct TextMessageView_Previews: PreviewProvider {
    static var previews: some View {
        TextMessageView()
    }
}
