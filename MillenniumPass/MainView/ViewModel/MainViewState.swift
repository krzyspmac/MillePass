//
//  MainViewState.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 08/10/2021.
//

import Foundation

extension MainView {
    enum Event: EventBase {
        case onAppear
    }
    
    enum State: StateBase {
        case idle
        case loading
        case loaded(item: MainView.Item)
        case error(error: Error)
        var navigationBarTitle: String { "Millennium Pass" }
    }
}

extension MainView.State: Equatable {
    static func == (lhs: MainView.State, rhs: MainView.State) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle): return true
        case (.loading, .loading): return true
        case (.loaded(let lhsData), .loaded(let rhsData)): return lhsData == rhsData
        case (.error, .error): return true
        default: return false
        }
    }
}
