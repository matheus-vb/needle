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
                        ForEach(searchViewModel.searchResults.indices, id: \.self) { index in
                            WorkspaceCardView(workspaceInfo: searchViewModel.searchResults[index], action: {
                                print(index)
                                workspaceViewModel.accessCode = workspaceViewModel.workspaces[index].accessCode
                                isDeleting.toggle()
                            })
                            .environmentObject(projectViewModel)
                        }
                    }.padding(.top, 4)
                    Spacer()
                        .frame(height: 20)
                }
            }.onAppear {
                searchViewModel.updateQuery()
            }
            .onChange(of: searchViewModel.query, perform: { _ in
                searchViewModel.updateQuery()
            })
        }
    }
}
