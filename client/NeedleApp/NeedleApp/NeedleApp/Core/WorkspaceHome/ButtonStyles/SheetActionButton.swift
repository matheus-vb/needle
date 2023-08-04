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
            
                    .background(Color.theme.mainGray)
                    .foregroundStyle(.white)
                    .cornerRadius(4.23)
            }
}

struct SecondarySheetActionButton: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
                configuration.label
                .padding(.vertical, 8)
                .padding(.horizontal, 36)
            
                .background(Color.theme.mainGreen)
                    .foregroundStyle(.black)
                    .cornerRadius(4.23)
            }
}
