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
        
            .font(.custom(SpaceGrotesk.regular.rawValue, size: 12))
            .padding(.horizontal, 200)
                .padding(.top, 6)
                .padding(.bottom, 5)
        
                .background(Color.theme.greenMain)
                .foregroundStyle(.black)
                .frame(width: 488, height: 30)
                .cornerRadius(24)
        }
    
    
}
