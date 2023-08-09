//
//  SheetActionButton.swift
//  NeedleApp
//
//  Created by Bof on 26/07/23.
//

import Foundation
import SwiftUI

struct PrimarySheetActionButton: ButtonStyle {
    var onHover = false
        func makeBody(configuration: Configuration) -> some View {
                configuration.label
                    .padding(.vertical, 8)
                    .padding(.horizontal, 36)
            
                    .background(onHover ? Color.theme.greenSecondary : Color.theme.greenMain)
            //.background(text == "Cancelar" || text == "Próximo" || text == "Começar" ? (onHover ? Color.theme.grayHover : Color.theme.blackMain) : (onHover ? Color.theme.greenSecondary : Color.theme.greenMain))
                    .foregroundStyle(.black)
                    .cornerRadius(4.23)
            }
}

struct SecondarySheetActionButton: ButtonStyle {
    var onHover = false
        func makeBody(configuration: Configuration) -> some View {
                configuration.label
                .padding(.vertical, 8)
                .padding(.horizontal, 36)
            
                .background(onHover ? Color.theme.grayHover : Color.theme.blackMain)
                    .foregroundStyle(.white)
                    .cornerRadius(4.23)
            }
}
