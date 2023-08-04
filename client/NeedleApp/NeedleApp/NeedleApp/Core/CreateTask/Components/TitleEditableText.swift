//
//  TitleEditableText.swift
//  NeedleApp
//
//  Created by jpcm2 on 04/08/23.
//

import SwiftUI

struct TitleEditableText: View {
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
            .font(.system(size: 40, weight: .bold))
    }
}
