//
//  FocusedCommand.swift
//  NeedleApp
//
//  Created by Jpsmor on 11/09/23.
//

import SwiftUI

public extension View {
    func focused(_ condition: FocusState<Bool>.Binding, key: KeyEquivalent, modifiers: EventModifiers = .command) -> some View {
        focused(condition)
            .background(Button("") {
                condition.wrappedValue = true
            }
            .keyboardShortcut(key, modifiers: modifiers)
            .hidden()
            )
    }
}
