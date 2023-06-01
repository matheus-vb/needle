//
//  PopUpCreateTaskComponents.swift
//  Needle
//
//  Created by lss8 on 01/06/23.
//

import SwiftUI

extension PopUpCreatTaskView {
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

