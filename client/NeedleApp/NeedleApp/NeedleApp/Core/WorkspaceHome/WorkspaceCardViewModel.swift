//
//  WorkspaceCardViewModel.swift
//  NeedleApp
//
//  Created by matheusvb on 22/08/23.
//

import Foundation
import SwiftUI

class WorkspaceCardViewModel<
    A: AuthenticationManagerProtocol & ObservableObject,
    T: TaskDataServiceProtocol & ObservableObject,
    W: WorkspaceDataServiceProtocol & ObservableObject
>: ObservableObject {
    @ObservedObject var authManager: A
    @ObservedObject var taskDS: T
    @ObservedObject var workspaceDS: W
    
    @Published var isHovered = false
    
    @Published var action: () -> Void
    @Published var workspace: Workspace
    
    init(manager: A, taskDS: T, workspaceDS: W, action: @escaping ()->Void, workspace: Workspace) {
        self.authManager = manager
        self.taskDS = taskDS
        self.workspaceDS = workspaceDS
        
        self.action = action
        self.workspace = workspace
    }
    
    func selectWorkspace(workspaceId: String) {
        authManager.getRoleInWorkspace(userId: authManager.user!.id, workspaceId: self.workspace.id)
        taskDS.getWorkspaceTasks(userId: authManager.user!.id, workspaceId: self.workspace.id)
        workspaceDS.getWorkspaceMembers(workspaceId: self.workspace.id)
    }
}
