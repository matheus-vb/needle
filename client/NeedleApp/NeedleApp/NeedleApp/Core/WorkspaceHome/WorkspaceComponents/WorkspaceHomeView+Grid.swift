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
        GeometryReader { geometry in
            ScrollView {
                NavigationStack {
                    LazyVGrid(columns: columns, spacing: geometry.size.height * 0.04) {
                        ForEach(workspaceViewModel.searchResults.indices, id: \.self) { index in
                            WorkspaceCardView(workspaceInfo: workspaceViewModel.searchResults[index], action: {
                                workspaceViewModel.accessCode = workspaceViewModel.workspaces[index].accessCode
                                workspaceViewModel.isDeleting.toggle()
                            })
                        }
                    }.padding(.top, 4)
                    Spacer()
                        .frame(height: 60)
                }
            }.onAppear {
                workspaceViewModel.updateQuery()
            }
            .onChange(of: workspaceViewModel.query, perform: { _ in
                workspaceViewModel.updateQuery()
            })
            .onChange(of: workspaceViewModel.selectedTab, perform: { _ in
                workspaceViewModel.updateQuery()
            })
        }
    }
}
