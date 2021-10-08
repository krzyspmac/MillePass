//
//  ContentView.swift
//  MillenniumPass
//
//  Created by krzysp on 08/10/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainView(viewModel: .init(state: .idle))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
