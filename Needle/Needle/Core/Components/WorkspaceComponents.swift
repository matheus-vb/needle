//
//  WorkspaceComponents.swift
//  Needle
//
//  Created by lss8 on 31/05/23.
//

import Foundation
import SwiftUI

extension WorkspaceView {
    
    struct addButtonStyle: ButtonStyle {
        
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .frame(minWidth: 450, idealWidth: 488, maxWidth: 488, minHeight: 32)
                .background(Color.color.mainBlack)
                .cornerRadius(8)
            
        }
    }
    
    struct InitialButtonStyle: ButtonStyle {
        
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .foregroundColor(Color.color.mainBlack)
                .background(Color.color.kanbanGray)
                .cornerRadius(10)
        }
    }
    
    struct workspaceCardView: View {
        let workspace: Workspace
        
        var body: some View {
            VStack{
                Spacer().frame(height: 24)
                
                HStack {
                    Spacer().frame(width: 24)
                    Text(workspace.name)
                        .font(.custom(.spaceGroteskBold, size: 32))
                        .foregroundColor(Color.color.mainBlack)
                    Spacer()
                    Image.icons.trash
                    Spacer().frame(width: 24)
                }
                Spacer()
                
                HStack{
                    Spacer()
                    
                    Text("#\(workspace.accessCode)")
                        .frame(width: 88, height: 32)
                        .font(.custom(.spaceGrotesk, size: 16))
                        .foregroundColor(Color.color.mainBlack)
                        .background(Color.color.mainGreen)
                        .cornerRadius(4)
                    Spacer().frame(width: 24)
                }
                
                Spacer().frame(height: 20)
                
            }.background(.white)
            .frame(width: 488, height: 284)
            .cornerRadius(8)
            .shadow(radius: 8)
            
            
        }
    }
    
}
