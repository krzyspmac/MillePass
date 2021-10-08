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
    
    typealias E = MainViewModel.Event
    typealias S = MainViewModel.State
    
    @Published
    var state: MainViewModel.State
    
    // MARK: - Properties
    
    
    // MARK: - Init
    
    init(state: MainViewModel.State = .idle) {
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
        state = .idle

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.state = .loading
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.state = .loaded(item: MockFactory.Views.Main.mainContentViewItem)
        }
    }
}

