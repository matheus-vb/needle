//
//  SearchWorkspaceModel.swift
//  NeedleApp
//
//  Created by Bof on 17/08/23.
//

import Foundation
import SwiftUI

class SearchWorkspaceModel: ObservableObject {
    @ObservedObject var workspaceViewModel = WorkspaceHomeViewModel()

    @Published var query: String = ""
    @Published var searchResults: [Workspace] = []
    
    init() {
        updateQuery()
    }
    
    func updateQuery() {
        if query == "" {
            searchResults = workspaceViewModel.workspaces
        }
        else {
            var newSearchResults: [Workspace] = []
            newSearchResults = searchResults.filter {
                $0.name.contains(query)
                
            }
            searchResults = newSearchResults
            print(searchResults)
        }
    }
}
