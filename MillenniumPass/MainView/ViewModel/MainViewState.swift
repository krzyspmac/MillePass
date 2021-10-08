//
//  MainViewState.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 08/10/2021.
//

import Foundation

extension MainViewModel {
    enum Event: EventBase {
        case onAppear
    }
    
    enum State: StateBase {
        case idle
        case loading
        case loaded(item: MainContentView.Item)
        case error(error: Error)
        var navigationBarTitle: String { "Millennium Pass" }
    }
}

extension MainViewModel.State: Equatable {
    static func == (lhs: MainViewModel.State, rhs: MainViewModel.State) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle): return true
        case (.loading, .loading): return true
        case (.loaded(let lhsData), .loaded(let rhsData)): return lhsData == rhsData
        case (.error, .error): return true
        default: return false
        }
    }
}
