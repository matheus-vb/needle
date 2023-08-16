//
//  JoinWorkspaceButton.swift
//  NeedleApp
//
//  Created by Bof on 02/08/23.
//

import Foundation
import SwiftUI

struct JoinWorkspaceButton: ButtonStyle {
    
    @State var onHover = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        
            .font(.custom(SpaceGrotesk.regular.rawValue, size: 16))
            .padding(.horizontal, 130)
                .padding(.top, 6)
                .padding(.bottom, 5)
                .background(onHover ? Color.theme.greenSecondary : Color.theme.greenMain)
                .foregroundStyle(.black)
                .cornerRadius(4)
                .shadow(radius: 10)
                .onHover { Bool in
                    onHover = Bool
                }

        }
    
    
}

struct JoinWorkspaceButton_Previews: PreviewProvider {
    static var previews: some View {
        Button("Criar") {}
            .buttonStyle(JoinWorkspaceButton())
    }
}
