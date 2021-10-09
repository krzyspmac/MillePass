//
//  MilleCoinView.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 09/10/2021.
//

import Foundation
import SwiftUI

struct MilleCoinView: View {
    
    @State var numberOfItems: Int = 0
    @State private var showDialog = false
    @StateObject var viewModel: MilleCoinViewModel
    
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
    
    private func mainView(with item: MilleCoinView.Item) -> some View {
        ScrollView {
            VStack {
//                HStack {
//                    Text("Co to jest Millecoin?")
//                        .font(.headline)
//                    Spacer()
//                }
                FlippingView(coins: item.coins)
                Color.clear.frame(height: 20)
                HStack {
                    Text("Jest to waluta do wykorzystania u partnerów banku.Możesz ją wymienić na wspaniałe nagrody.")
                        .font(.caption)
                    Spacer()
                }
                Color.clear.frame(height: 20)
                HStack(spacing: 0) {
                    Text("Twoje millecoiny: ")
                        .font(.body)
                    Text(item.coins)
                        .font(.headline)
                    Image("mille_icon")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(.magenta)
                    Spacer()
                }
                
                Button {
                    showDialog = true
                } label: {
                    Text("Send coins")
                }
                
            }
        }.customDialog(isShowing: $showDialog) { // HERE
            VStack {
                Text("Send Coins")
                    .fontWeight(.bold)
                Divider()
                Stepper(value: $numberOfItems, in: 0...10, label: { Text("Coins to send:  \(numberOfItems)")})
                    .padding(.bottom, 10)
                
                HStack {
                    Button(action: {
                        showDialog = false
                    }) {
                        Text("Close")
                            .autocapitalization(.allCharacters)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                    }
                    
                    Button(action: {
                        showDialog = false
                    }) {
                        Text("Send")
                            .autocapitalization(.allCharacters)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                    }
                }
                
            }.padding()
        }
    }
    
    private var viewTest: some View {
        ZStack {
            Circle()
                .stroke(style: StrokeStyle( lineWidth: 5, dash: [3]))
                .foregroundColor(.magenta)
                .frame(width: 100, height: 100)
            Image("mille_icon")
                .resizable()
                .frame(width: 60, height: 60)
        }.frame(height: 100)
            .hidden()
    }
}

struct MilleCoinView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MilleCoinViewModel(
            state: .loaded(item: .init(coins: "56"))
        )
        return MilleCoinView(viewModel: viewModel)
    }
}

extension MilleCoinView {
    struct Item: Equatable {
        let coins: String
        //        let rows: [MilleStartsRowView.Item]
    }
}
