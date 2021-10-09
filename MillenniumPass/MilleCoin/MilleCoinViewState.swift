//
//  MilleCoinViewState.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 09/10/2021.
//

import Foundation

extension MilleCoinViewModel {
    enum Event: EventBase {
        case onAppear
    }
    
    enum State: StateBase {
        case idle
        case loading
        case loaded(item: MilleCoinView.Item)
        case error(error: Error)
        var navigationBarTitle: String { "Your Millecoins" }
    }
}

extension MilleCoinViewModel.State: Equatable {
    static func == (lhs: MilleCoinViewModel.State, rhs: MilleCoinViewModel.State) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle): return true
        case (.loading, .loading): return true
        case (.loaded(let lhsData), .loaded(let rhsData)): return lhsData == rhsData
        case (.error, .error): return true
        default: return false
        }
    }
}

