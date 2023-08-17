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
        HStack(alignment: .center, spacing: 184){
            DashedButton(text: workspaceViewModel.selectedTab.buttonTitle, isWorkspace: true, onButtonTapped: {
                workspaceViewModel.selectedTab == .joinedWorkspaces ? isJoining.toggle() : isNaming.toggle()
            })
            Text(workspaceViewModel.selectedTab.headerTitle)
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(Color.theme.blackMain)
                .frame(width: 400)
            
            TextField("Procurar por nome do projeto...", text: $searchViewModel.query)
                .frame(width: 320, height: 32)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}
