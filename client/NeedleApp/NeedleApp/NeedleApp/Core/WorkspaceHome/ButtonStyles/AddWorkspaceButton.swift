//
//  AddWorkspaceButton.swift
//  NeedleApp
//
//  Created by Bof on 26/07/23.
//

import Foundation
import SwiftUI


struct AddWorkspaceButton: ButtonStyle {
    
    @State var onHover = false
    
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
        
            .font(.custom(SpaceGrotesk.regular.rawValue, size: 16))
            .padding(.horizontal, 150)
                .padding(.top, 6)
                .padding(.bottom, 5)
                .background(onHover ? Color.theme.grayHover : Color.theme.blackMain)
                .foregroundStyle(.white)
                .cornerRadius(4)
                .shadow(radius: 10)
                .onHover { Bool in
                    onHover = Bool
                }

        }
    
    
}
