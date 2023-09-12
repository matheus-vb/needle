//
//  WorkspacHomeViewModel.swift
//  NeedleApp
//
//  Created by matheusvb on 03/08/23.
//

import Foundation
import Combine
import SwiftUI

class WorkspaceHomeViewModel<
    W: WorkspaceDataServiceProtocol & ObservableObject
>: ObservableObject {
    @AppStorage("userID") var userID: String = "Default User"

    @Published var query: String = ""
    @Published var searchResults: [Workspace] = []
        
    @Published var workspaces: [Workspace] = []
    
    @Published var accessCode: String?
    
    @Published var selectedTab: WorkspaceTab = .myWorkspaces
            
    @Published var isDeleting = false
    @Published var isNaming = false
    @Published var isJoining = false
    @Published var isAnimating = false
    @Published var showMain = false
    
    var workspaceDS: W
    
    private var cancellables = Set<AnyCancellable>()
    
    init(workspaceDS: W) {
        self.workspaceDS = workspaceDS
        
        addSubscribers()
    }
    
    func addSubscribers() {
        workspaceDS.workspacePublisher
            .sink(receiveValue: { [weak self] returnedWorkspaces in
                self?.workspaces = returnedWorkspaces
                
                if self?.selectedTab == .joinedWorkspaces {
                    self?.searchResults = returnedWorkspaces.filter({ $0.users[0].userId != self?.userID })
                } else {
                    self?.searchResults = returnedWorkspaces.filter({ $0.users[0].userId == self?.userID })
                }
            })
            .store(in: &cancellables)
    }
    
    func loadData() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        DispatchQueue.main.async {
            withAnimation {
                self.showMain = true
            }
        }
    }
    
    func updateTab() {
        print("\(selectedTab)")
        var newTabResults: [Workspace] {
            if selectedTab == .myWorkspaces {
                return workspaces.filter {
                    userID == $0.users[0].userId
                }
            }
            else {
                print("entrei")
                return workspaces.filter {
                    userID != $0.users[0].userId
                }
            }
        }
        searchResults = newTabResults
    }
    
    func updateQuery() {
        if query == "" {
            self.updateTab()
        }
        else {
            var newSearchResults: [Workspace] = []
            newSearchResults = searchResults.filter {
                $0.name.lowercased().contains(query.lowercased())
            }
            searchResults = newSearchResults
        }
    }

}
