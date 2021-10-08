//
//  ViewModel.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 08/10/2021.
//

import Foundation
import Combine

/// Represent base event to use in viewModel.
public protocol EventBase: Equatable {}

/// Represent base state to use in viewModel.
public protocol StateBase: Equatable {}


public protocol ViewModel: ObservableObject {
    associatedtype E: EventBase
    associatedtype S: StateBase
    
    /// Current state of state machine.
    var state: S { get }
    
    /// Add new ``Event`` to state machine.
    /// - Parameter event: A new ``Event`` to dispatch.
    func add(_ event: E)
    
}
