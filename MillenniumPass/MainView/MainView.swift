//
//  MainView.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 08/10/2021.
//

import SwiftUI
import Combine

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroudColor.edgesIgnoringSafeArea(.all)
                content
                    .navigationBarTitle(viewModel.state.navigationBarTitle)
            }
        }
        .onLoad(isDebug: false, perform: { viewModel.add(.onAppear) })
    }
    
    private var content: some View {
        switch viewModel.state {
        case .idle:
            return Color.clear.asAnyView
        case .loading:
            return SpinnerView(isAnimating: true, style: .large).asAnyView
        case .error(let error):
            return Text(error.localizedDescription).asAnyView
        case .loaded(let data):
            return mainView(with: data).asAnyView
        }
    }
    
    private func mainView(with item: MainView.Item) -> some View {
        return MainContentView(item: .init())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel: MainViewModel = MainViewModel(
            state: .idle
        )
        return MainView(viewModel: viewModel)
    }
}


extension MainView {
    struct Item: Equatable {
        
    }
}
