//
//  WorkspaceHomeView+Header.swift
//  NeedleApp
//
//  Created by Bof on 16/08/23.
//

import Foundation
import SwiftUI

extension WorkspaceHomeView {
    var header: some View {
<<<<<<< HEAD
            HStack(alignment: .center){
                Spacer()
                DashedButton(text: workspaceViewModel.selectedTab.buttonTitle, isWorkspace: true, onButtonTapped: {
                    workspaceViewModel.selectedTab == .joinedWorkspaces ? workspaceViewModel.isJoining.toggle() :  workspaceViewModel.isNaming.toggle()
                })
                .keyboardShortcut("n", modifiers: .command)
                Spacer()
                    .frame(maxWidth: 360)
                Text(workspaceViewModel.selectedTab.headerTitle)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Color.theme.blackMain)
                    .frame(minWidth: 400)
                Spacer()
                    .frame(maxWidth: 360)
                TextField("Procurar por nome do projeto...", text: $workspaceViewModel.query)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: 320)
                Spacer()
            }
=======
        HStack(alignment: .center){
            DashedButton(text: workspaceViewModel.selectedTab.buttonTitle, isWorkspace: true, onButtonTapped: {
                workspaceViewModel.selectedTab == .joinedWorkspaces ? workspaceViewModel.isJoining.toggle() :  workspaceViewModel.isNaming.toggle()
            })
            .keyboardShortcut("n", modifiers: .command)
            Spacer()
            Text(workspaceViewModel.selectedTab.headerTitle)
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(Color.theme.blackMain)
                //.frame(width: 400)
            Spacer()
            TextField("Procurar por nome do projeto...", text: $workspaceViewModel.query)
                .frame(width: 320, height: 32)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .modifier(searchFieldModifier())
        }
>>>>>>> develop
    }
}
