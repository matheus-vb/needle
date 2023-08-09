//
//  JoinWorkspaceButton.swift
//  NeedleApp
//
//  Created by Bof on 02/08/23.
//

import Foundation
import SwiftUI

struct JoinWorkspaceButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        
            .font(.custom(SpaceGrotesk.regular.rawValue, size: 16))
            .padding(.horizontal, 150)
                .padding(.top, 6)
                .padding(.bottom, 5)
        
                .background(Color.theme.greenMain)
                .foregroundStyle(.black)
                .cornerRadius(4)
                .shadow(radius: 10)
        }
    
    
}

struct JoinWorkspaceButton_Previews: PreviewProvider {
    static var previews: some View {
        Button("Criar") {}
            .buttonStyle(JoinWorkspaceButton())
    }
}
