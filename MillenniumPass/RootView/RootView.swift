//
//  RootView.swift
//  MillenniumPass
//
//  Created by krzysp on 08/10/2021.
//

import SwiftUI

struct RootView: View {

    @StateObject var viewModel: RootViewModel

    var body: some View {
        switch viewModel.state {
        case .welcome:
            WelcomeScreen()
        case .sms:
            TextMessageView()
        }
    }
}
