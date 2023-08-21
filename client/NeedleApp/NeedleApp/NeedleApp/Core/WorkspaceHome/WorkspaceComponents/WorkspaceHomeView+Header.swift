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
        HStack(alignment: .center){
            DashedButton(text: workspaceViewModel.selectedTab.buttonTitle, isWorkspace: true, onButtonTapped: {
                workspaceViewModel.selectedTab == .joinedWorkspaces ? isJoining.toggle() : isNaming.toggle()
            })
            Spacer()
            Text(workspaceViewModel.selectedTab.headerTitle)
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(Color.theme.blackMain)
                //.frame(width: 400)
            Spacer()
            TextField("Procurar por nome do projeto...", text: $searchViewModel.query)
                .frame(width: 320, height: 32)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}
