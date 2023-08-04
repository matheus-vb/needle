//
//  SheetActionButton.swift
//  NeedleApp
//
//  Created by Bof on 26/07/23.
//

import Foundation
import SwiftUI

struct PrimarySheetActionButton: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
                configuration.label
                    .padding(.vertical, 8)
                    .padding(.horizontal, 36)
            
                    .background(Color.theme.grayBackground)
                    .foregroundStyle(.white)
                    .cornerRadius(4.23)
            }
}

struct SecondarySheetActionButton: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
                configuration.label
                .padding(.vertical, 8)
                .padding(.horizontal, 36)
            
                .background(Color.theme.greenMain)
                    .foregroundStyle(.black)
                    .cornerRadius(4.23)
            }
}
