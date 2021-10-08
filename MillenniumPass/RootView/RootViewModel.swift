//
//  RootViewModel.swift
//  MillenniumPass
//
//  Created by krzysp on 08/10/2021.
//

import UIKit
import Foundation
import Combine

final class RootViewModel: ObservableObject {

    static let shared: RootViewModel = .init()

    enum State {
        case welcome
        case sms
        case main
    }

    @Published var state: State = .welcome

    init() {
    }
}
