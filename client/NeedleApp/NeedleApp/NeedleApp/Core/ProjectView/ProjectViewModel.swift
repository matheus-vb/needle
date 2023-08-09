//
//  ProjectViewModel.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//

import Foundation
import Combine
import SwiftUI

class ProjectViewModel: ObservableObject{
    @AppStorage("userID") var userID: String = "Default User"
    @Published var selectedTab: SelectedTab = .Kanban 
    @Published var selectedProject: Workspace = Workspace(id: "id1", accessCode: "", name: "")
    @Published var projects: [Workspace] = [Workspace(id: "1", accessCode: "123", name: "Projeto"), Workspace(id: "id1", accessCode: "", name: ""),Workspace(id: "id1", accessCode: "", name: ""),Workspace(id: "id1", accessCode: "", name: "")]
    
    @Published var tasks: [String:[TaskModel]] = [:]
    @Published var workspaceMembers: [String:[User]] = [:]
    @Published var roles: [String: String] = [:]
    
    @Published var showPopUp: Bool = false
    @Published var showEditTaskPopUP: Bool = false
    @Published var selectedColumnStatus: TaskStatus = .TODO
    @Published var triggerLoading = false
    @Published var selectedTask: TaskModel?
    
    private var worskpaceDS = WorkspaceDataService.shared
    private var tasksDS = TaskDataService.shared
    private var authMGR = AuthenticationManager.shared
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
        
        tasksDS.$allUsersTasks
            .sink(receiveValue: { [weak self] returnedTasks in
                self?.tasks = returnedTasks
            })
            .store(in: &cancellables)
        
        worskpaceDS.$members
            .sink(receiveValue: { [weak self] returnedUsers in
                self?.workspaceMembers = returnedUsers
            })
            .store(in: &cancellables)
        
        authMGR.$roles
            .sink(receiveValue: { [weak self] returnedRoles in
                self?.roles = returnedRoles
            })
            .store(in: &cancellables)
    }
    
    func createTask(dto: CreateTaskDTO){
        tasksDS.createTask(dto: dto, userId: userID, workspaceId: selectedProject.id)
    }
}
