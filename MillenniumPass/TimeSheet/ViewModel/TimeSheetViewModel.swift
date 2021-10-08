//
//  TimeSheetViewModel.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 08/10/2021.
//

import Foundation

final class TimeSheetViewModel: ViewModel {
    
    typealias E = TimeSheetView.Event
    typealias S = TimeSheetView.State
    
    @Published
    var state: TimeSheetView.State
    
    // MARK: - Properties
    
    
    // MARK: - Init
    
    init(state: TimeSheetView.State = .idle) {
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
            self.state = .loaded(item: MockFactory.Views.TimeSheet.timeSheetViewItem)
        }
    }
}

