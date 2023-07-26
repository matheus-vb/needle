//
//  EditableText.swift
//  NeedleApp
//
//  Created by jpcm2 on 26/07/23.
//

import SwiftUI

struct EditableText: View {
    @Binding var text: String

    @State private var temporaryText: String
    @FocusState private var isFocused: Bool

    init(text: Binding<String>) {
        self._text = text
        self.temporaryText = text.wrappedValue
    }

    var body: some View {
        TextField("", text: $temporaryText, onCommit: { text = temporaryText })
            .focused($isFocused, equals: true)
            .onTapGesture { isFocused = true }
            .onExitCommand { temporaryText = text; isFocused = false }
            .textFieldStyle(.plain)
    }
}
