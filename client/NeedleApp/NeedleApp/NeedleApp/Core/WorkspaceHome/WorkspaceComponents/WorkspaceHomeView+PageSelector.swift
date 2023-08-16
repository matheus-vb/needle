//
//  WorkspaceHomeView+PageSelector.swift
//  NeedleApp
//
//  Created by Bof on 16/08/23.
//

import Foundation
import SwiftUI

extension WorkspaceHomeView {
    var pageSelector: some View {
        GeometryReader {geometry in
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                HStack(spacing: 48) {
                    Spacer()
                    Button(action: {
                        workspaceViewModel.selectedTab = .myWorkspaces
                    }, label: {
                        Text("Meus projetos")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.black)
                            .overlay(
                                Rectangle()
                                    .frame(height: 6)
                                    .foregroundColor(workspaceViewModel.selectedTab == .myWorkspaces ? Color.theme.greenMain: Color.theme.grayBackground)
                                    .offset(y: 12)
                                , alignment: .bottom
                            )
                    })
                    .buttonStyle(.plain)
                    
                    Button(action: {
                        workspaceViewModel.selectedTab = .joinedWorkspaces
                    }, label: {
                        Text("Projetos que participo")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.black)
                            .overlay(
                                Rectangle()
                                    .frame(height: 6)
                                    .foregroundColor(workspaceViewModel.selectedTab == .joinedWorkspaces ? Color.theme.greenMain: Color.theme.grayBackground)
                                    .offset(y: 12)
                                , alignment: .bottom
                            )
                    })
                    .buttonStyle(.plain)
                    Spacer()
                }
            }.frame(width: geometry.size.width, height: geometry.size.height * 0.2)
        }
    }
}
