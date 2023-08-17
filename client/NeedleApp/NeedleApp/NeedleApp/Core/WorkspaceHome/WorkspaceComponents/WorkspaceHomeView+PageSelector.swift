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
                HStack(spacing: 48) {
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
                }.padding(.leading, geometry.size.width * 0.17)
                .padding(.top, geometry.size.width * 0.06)
                .padding(.bottom, geometry.size.width * 0.03)
                .background(.white)
        }
    }
}
