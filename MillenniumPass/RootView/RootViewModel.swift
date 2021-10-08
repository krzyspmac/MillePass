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

    enum State {
        case welcome
        case sms
    }

    @Published var state: State = .welcome
}
