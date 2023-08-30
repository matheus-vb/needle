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
    private var workspaceDS: W
    
    @Published var workspaces: [Workspace] = []
    
    @Published var accessCode: String?
    
    @Published var selectedTab: WorkspaceTab = .myWorkspaces
        
    private var workspaceDS = WorkspaceDataService.shared
    @Published var isDeleting = false
    @Published var isNaming = false
    @Published var isJoining = false
    @Published var isAnimating = false
    @Published var showMain = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(workspaceDS: W) {
        self.workspaceDS = workspaceDS
        
        addSubscribers()
    }
    
    func addSubscribers() {
        workspaceDS.workspacePublisher
            .sink(receiveValue: { [weak self] returnedWorkspaces in
                self?.workspaces = returnedWorkspaces
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
}
