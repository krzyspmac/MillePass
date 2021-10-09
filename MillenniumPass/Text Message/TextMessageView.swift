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
        LinearGradient(gradient: Gradient(colors: [Color.white, Color.white]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.vertical)
            .overlay(
                VStack {
                    Text("Time to activate!")
                        .font(.system(.title, design: .rounded))
                        .multilineTextAlignment(.center)
                    Text("Enter the sms code")
                        .font(.system(.body, design: .rounded))
                        .multilineTextAlignment(.center)
                    TextField("SMS code", text: $smsString)
                        .font(.system(.body, design: .rounded))
                        .multilineTextAlignment(.center)
                        .padding(20)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
//                    Spacer()
                    Button("Authorize".uppercased()) {
                        if smsString == "1111" {
                            print("You shall pass jeden")
                            UserManager.shared.user = User.fromIdentifier(1)
                            RootViewModel.shared.state = .main
                        } else if smsString == "2222" {
                            print("You shall pass dwa")
                            UserManager.shared.user = User.fromIdentifier(2)
                            RootViewModel.shared.state = .main
                        } else {
                            showingAlert = true
                        }
                    }
//                    .foregroundColor(.black)
                    Spacer()
                    Text("Copyright © Bank Millennium SA")
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.white)
                }
                .padding([.top, .horizontal])
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

