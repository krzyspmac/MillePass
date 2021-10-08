//
//  MilleStartsViewState.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 08/10/2021.
//

extension MilleStartsView {
    enum Event: EventBase {
        case onAppear
    }
    
    enum State: StateBase {
        case idle
        case loading
        case loaded(item: MilleStartsView.Item)
        case error(error: Error)
        var navigationBarTitle: String { "Miłe początki" }
    }
}

extension MilleStartsView.State: Equatable {
    static func == (lhs: MilleStartsView.State, rhs: MilleStartsView.State) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle): return true
        case (.loading, .loading): return true
        case (.loaded(let lhsData), .loaded(let rhsData)): return lhsData == rhsData
        case (.error, .error): return true
        default: return false
        }
    }
}

