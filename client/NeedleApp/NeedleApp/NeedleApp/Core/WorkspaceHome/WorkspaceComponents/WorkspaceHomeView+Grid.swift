//
//  WorkspaceHomeView+Grid.swift
//  NeedleApp
//
//  Created by Bof on 16/08/23.
//

import Foundation
import SwiftUI

extension WorkspaceHomeView {
    var workspaceGrid: some View {
        LazyVGrid(columns: columns, spacing: 48) {
            ForEach(workspaceViewModel.workspaces.indices, id: \.self) { index in
                WorkspaceCardView(workspaceInfo: workspaceViewModel.workspaces[index], action: {
                    workspaceViewModel.accessCode = workspaceViewModel.workspaces[index].accessCode
                    isDeleting.toggle()
                })
                .environmentObject(projectViewModel)
            }
        }
        .frame(width: 1000)
    }
}
