//
//  LoggedInView.swift
//  MillenniumPass
//
//  Created by krzysp on 09/10/2021.
//

import Foundation
import SwiftUI

struct LoggedInView: View {

    @StateObject
    var userManager: UserManager = .shared

    private var dateFormatter: DateFormatter

    var body: some View {
        if userManager.isLoggedIn {
            VStack {
                Color.clear.frame(height: 5)

                Text("Logged in at \(dateFormatter.string(from: Date()))")
                    .bold()

                Color.clear.frame(height: 5)
            }
            .background(Color.white)
            .cornerRadius(10)
        } else {
            EmptyView()
        }
    }

    init(userManager: UserManager) {
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
    }
}

struct LoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(name: "Name", surname: "Surname", imageBase64: "")
        UserManager.shared.isLoggedIn = true
        return LoggedInView(userManager: UserManager.shared)
    }
}

