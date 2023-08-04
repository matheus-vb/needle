//
//  ProjectViewModel.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//

import Foundation
import Combine

class ProjectViewModel: ObservableObject{
    @Published var selectedTab: SelectedTab = .Kanban 
    @Published var selectedProject: Workspace = Workspace(id: "id1", accessCode: "", name: "")
    @Published var projects: [Workspace] = []
    
    @Published var triggerLoading = false
    
    private var worskpaceDS = WorkspaceDataService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        worskpaceDS.$workspaces
            .sink(receiveValue: { [weak self] returnedWorkspaces in
                self?.projects = returnedWorkspaces
            })
            .store(in: &cancellables)
    }
}
