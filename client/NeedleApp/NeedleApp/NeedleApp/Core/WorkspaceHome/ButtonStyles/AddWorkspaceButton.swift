//
//  AddWorkspaceButton.swift
//  NeedleApp
//
//  Created by Bof on 26/07/23.
//

import Foundation
import SwiftUI


struct AddWorkspaceButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
        
            .font(.footnote)
            .padding(.horizontal, 200)
                .padding(.top, 6)
                .padding(.bottom, 5)
        
                .background(Color.theme.blackMain)
                .foregroundStyle(.white)
                .frame(width: 488, height: 30)
                .cornerRadius(12)
        }
    
    
}
