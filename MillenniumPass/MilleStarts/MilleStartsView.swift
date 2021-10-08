//
//  MilleStartsView.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 08/10/2021.
//

import SwiftUI

struct MilleStartsView: View {
    
    @StateObject var viewModel: MilleStartsViewModel
    
    var body: some View {
        ZStack {
            Color.backgroudColor.edgesIgnoringSafeArea(.all)
            content
                .padding(.horizontal, 10)
                .navigationBarTitle(viewModel.state.navigationBarTitle)
        }
        .onLoad(isDebug: false, perform: { viewModel.add(.onAppear) })
    }
    
    private var content: some View {
        switch viewModel.state {
        case .idle:
            return Color.clear.asAnyView
        case .loading:
            return MilleLoaderView().asAnyView
        case .error(let error):
            return Text(error.localizedDescription).asAnyView
        case .loaded(let data):
            return mainView(with: data).asAnyView
        }
    }
    
    private func mainView(with item: MilleStartsView.Item) -> some View {
        ScrollView {
            VStack {
                Color.clear.frame(height: 20)
                ForEach(Array(item.rows.enumerated()), id: \.offset) { index, itemRow in
                    MilleStartsRowView(item: itemRow)
                }
                Color.clear.frame(height: 20)
            }
        }
    }
}

struct MilleStartsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MilleStartsViewModel(
            state: .loaded(item: MockFactory.Views.MilleStart.milleStartViewItem)
        )
        return MilleStartsView(viewModel: viewModel)
    }
}

extension MilleStartsView {
    struct Item: Equatable {
        let rows: [MilleStartsRowView.Item]
    }
}

