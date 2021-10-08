//
//  TimeSheetViewState.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 08/10/2021.
//

import Foundation

extension TimeSheetView {
    enum Event: EventBase {
        case onAppear
    }
    
    enum State: StateBase {
        case idle
        case loading
        case loaded(item: TimeSheetView.Item)
        case error(error: Error)
        var navigationBarTitle: String { "Millennium Time Sheet" }
    }
}

extension TimeSheetView.State: Equatable {
    static func == (lhs: TimeSheetView.State, rhs: TimeSheetView.State) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle): return true
        case (.loading, .loading): return true
        case (.loaded(let lhsData), .loaded(let rhsData)): return lhsData == rhsData
        case (.error, .error): return true
        default: return false
        }
    }
}
