//
//  MilleStartsViewModel.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 08/10/2021.
//

import Foundation

final class MilleStartsViewModel: ViewModel {
    
    typealias E = MilleStartsView.Event
    typealias S = MilleStartsView.State
    
    @Published
    var state: MilleStartsView.State
    
    // MARK: - Properties
    
    
    // MARK: - Init
    
    init(state: MilleStartsView.State = .idle) {
        self.state = state
    }
    
    // MARK: Handle new event
    
    func add(_ event: E) {
        switch event {
        case .onAppear:
            onViewDidAppear()
        }
    }
    
    private func onViewDidAppear() {
        state = .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.state = .loaded(item: MockFactory.Views.MilleStart.milleStartViewItem)
        }
    }
}

