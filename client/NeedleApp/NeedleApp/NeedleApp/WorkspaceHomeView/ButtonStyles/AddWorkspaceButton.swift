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
                .padding(.horizontal, 238)
                .padding(.top, 11.93)
                .padding(.bottom, 11.07)
        
                .background(Color("main-grey"))
                .foregroundStyle(.white)
                .frame(width: 488, height: 30)
                .cornerRadius(12)
        }
    
    
}
