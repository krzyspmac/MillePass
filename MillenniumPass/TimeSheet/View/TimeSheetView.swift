//
//  TimeSheetView.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 08/10/2021.
//

import SwiftUI

struct TimeSheetView: View {
    
    @StateObject var viewModel: TimeSheetViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroudColor.edgesIgnoringSafeArea(.all)
                ScrollView {
                    content
                }
                .navigationBarTitle(viewModel.state.navigationBarTitle)
            }
        }
        .onLoad(isDebug: true, perform: { viewModel.add(.onAppear) })
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
    
    private func mainView(with item: TimeSheetView.Item) -> some View {
        return TimeSheetListView(items: TimeSheetListView.mockItems)
    }
}

struct TimeSheetView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TimeSheetViewModel(
            state: .loaded(item: .init())
        )
        return TimeSheetView(viewModel: viewModel)
    }
}

extension TimeSheetView {
    struct Item: Equatable {
        
    }
}
