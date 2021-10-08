//
//  MainViewModel.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 08/10/2021.
//

import Foundation
import Combine
import SwiftUI

final class MainViewModel: ViewModel {
    
    typealias E = MainView.Event
    typealias S = MainView.State
    
    @Published
    var state: MainView.State
    
    // MARK: - Properties
    
    
    // MARK: - Init
    
    init(state: MainView.State = .idle) {
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
            self.state = .loaded(item: MockFactory.Views.Main.mainContentViewItem)
        }
    }
}

