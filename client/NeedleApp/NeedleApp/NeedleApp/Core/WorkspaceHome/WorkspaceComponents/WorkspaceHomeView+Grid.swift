//
//  WorkspaceHomeView+Grid.swift
//  NeedleApp
//
//  Created by Bof on 16/08/23.
//

import Foundation
import SwiftUI

extension WorkspaceHomeView {
    
    func returnWorkspaces() -> [Workspace] {
        var returnedArray: [Workspace] = []
        if workspaceViewModel.selectedTab == .myWorkspaces {
            for item in searchViewModel.searchResults {
                if item.users[0].userId == projectViewModel.userID {
                    returnedArray.append(item)
                }
            }
        }
        else {
            returnedArray = searchViewModel.searchResults.filter { !returnedArray.contains($0) }
        }
        return returnedArray
    }
    
    var workspaceGrid: some View {
        GeometryReader { geometry in
            ScrollView {
                NavigationStack {
                    LazyVGrid(columns: columns, spacing: geometry.size.height * 0.04) {
                        ForEach(returnWorkspaces().indices, id: \.self) { index in
                            WorkspaceCardView(workspaceInfo: returnWorkspaces()[index], action: {
                                print(index)
                                workspaceViewModel.accessCode = workspaceViewModel.workspaces[index].accessCode
                                isDeleting.toggle()
                            })
                            .environmentObject(projectViewModel)
                        }
                    }.padding(.top, 4)
                    Spacer()
                        .frame(height: 60)
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
