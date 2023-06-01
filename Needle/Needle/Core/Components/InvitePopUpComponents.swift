//
//  InvitePopUpComponents.swift
//  Needle
//
//  Created by MLaura on 31/05/23.
//

import SwiftUI

extension InvitePopUpView {
    struct initialButtonStyle: ButtonStyle {
        let fontColor: Color
        let bgColor: Color
        
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .foregroundColor(fontColor)
                .background(bgColor)
                .cornerRadius(4)
        }
    }
}
