////
////  SearchWorkspaceModel.swift
////  NeedleApp
////
////  Created by Bof on 17/08/23.
////
//
//import Foundation
//import SwiftUI
//
//class SearchWorkspaceModel: ObservableObject {
//    @AppStorage("userID") var userID: String = "Default User"
//
//    @ObservedObject var workspaceViewModel: WorkspaceHomeViewModel<WorkspaceDataService>
//
//    @Published var query: String = ""
//    @Published var searchResults: [Workspace] = []
//
//    init(workspaceViewModel: WorkspaceHomeViewModel<WorkspaceDataService>) {
//        self.workspaceViewModel = workspaceViewModel
//        updateTab()
//        updateQuery()
//    }
//
//    func updateTab() {
//        print("\(workspaceViewModel.selectedTab)")
//        var newTabResults: [Workspace] {
//            if workspaceViewModel.selectedTab == .myWorkspaces {
//                return workspaceViewModel.workspaces.filter {
//                    userID == $0.users[0].userId
//                }
//            }
//            else {
//                print("entrei")
//                return workspaceViewModel.workspaces.filter {
//                    userID != $0.users[0].userId
//                }
//            }
//        }
//        searchResults = newTabResults
//    }
//
//    func updateQuery() {
//        if query == "" {
//            self.updateTab()
//        }
//        else {
//            var newSearchResults: [Workspace] = []
//            newSearchResults = searchResults.filter {
//                $0.name.contains(query)
//            }
//            searchResults = newSearchResults
//        }
//    }
//
//}
