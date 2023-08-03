//
//  WorkspacHomeViewModel.swift
//  NeedleApp
//
//  Created by matheusvb on 03/08/23.
//

import Foundation
import Combine


class WorkspaceHomeViewModel: ObservableObject {
    @Published var workspaces: [Workspace] = []
    
    private var workspaceDS = WorkspaceDataService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        workspaceDS.$workspaces
            .sink(receiveValue: { [weak self] returnedWorkspaces in
                self?.workspaces = returnedWorkspaces
            })
            .store(in: &cancellables)
    }
}
