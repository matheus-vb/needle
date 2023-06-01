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
                .frame(width: 488, height: 32)
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
        let workspace: WorkspaceGridModel
        
        var body: some View {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                VStack {
                    VStack(spacing: 8.0) {
                        HStack {
                            Text(workspace.name)
                                .font(.custom(.spaceGrotesk, size: 32))
                                .foregroundColor(Color.color.mainBlack)
                            Spacer()
                            Image.icons.trash
                        }
                        HStack {
                            Text("owner | \(workspace.owner)")
                                .font(.custom(.spaceGrotesk, size: 32))
                                .foregroundColor(Color.color.mainBlack)
                            Spacer()
                        }
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Text("#\(workspace.accessCode)")
                            .font(.custom(.spaceGrotesk, size: 16))
                            .foregroundColor(Color.color.mainBlack)
                            .background(
                                RoundedRectangle(cornerRadius: 4, style: .circular)
                                    .fill(Color.color.mainGreen)
                                    .frame(width: 88, height: 32)
                            )
                    }
                    
                }
                .padding(.all, 24.0)
            }
            .frame(width: 488, height: 284)
            .cornerRadius(8)
            .shadow(radius: 8)
        }
    }
    
}
