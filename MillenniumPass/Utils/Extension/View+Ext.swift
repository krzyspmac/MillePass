//
//  View+Ext.swift
//  MillenniumPass
//
//  Created by Grzegorz Makowski on 08/10/2021.
//

import Combine
import SwiftUI

public struct ViewDidLoadModifier: ViewModifier {
    @State private var didLoad = false
    private let isDebug: Bool
    private let action: (() -> Void)?

    init(isDebug: Bool, action: (() -> Void)? = nil) {
        self.isDebug = isDebug
        self.action = action
    }

    public func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false, isDebug == false {
                didLoad = true
                action?()
            }
        }
    }
}

public extension View {
    /// This modifier is just same as ``onAppear``, but it will just call the first time that view appear
    /// - Parameter action: action to preform
    /// - Returns: some View
    func onLoad(isDebug: Bool, perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(isDebug: isDebug, action: action))
    }
    
    var asAnyView: AnyView { AnyView(self) }
}
