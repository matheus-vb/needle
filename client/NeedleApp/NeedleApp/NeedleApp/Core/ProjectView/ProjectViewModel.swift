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
    @EnvironmentObject var workspaceModel: WorkspaceHomeViewModel

    @AppStorage("userID") var userID: String = "Default User"
    @Published var selectedTab: SelectedTab = .Kanban 
    @Published var selectedProject: Workspace = Workspace(id: "id1", accessCode: "", name: "", users: [])
    @Published var projects: [Workspace] = [Workspace(id: "1", accessCode: "123", name: "Projeto", users: [])]
    
    @Published var tasks: [String:[TaskModel]] = [:]
    @Published var workspaceMembers: [String:[User]] = [:]
    @Published var roles: [String: String] = [:]
    
    @Published var showPopUp: Bool = false
    @Published var showEditTaskPopUP: Bool = false
    @Published var selectedColumnStatus: TaskStatus = .TODO
    @Published var triggerLoading = false
    @Published var selectedTask: TaskModel?
    
    @Published var showCard: Bool = false
    
    @Published var showShareCode = false
    
    private var worskpaceDS = WorkspaceDataService.shared
    private var tasksDS = TaskDataService.shared
    private var authMGR = AuthenticationManager.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        addSubscribers()
    }
    
    func getCode() -> String {
        return selectedProject.accessCode
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
    
    func deleteTask(){
        tasksDS.deleteTask(dto: DeleteTaskDTO(taskId: selectedTask!.id ?? "1"), userId: userID, workspaceId: selectedProject.id)
    }
    func presentCard() {
        DispatchQueue.main.async {
            Task {
                self.showCard = true
                
                try? await Task.sleep(nanoseconds: 5_000_000_000)
                
                self.showCard = false
            }
        }
    }
    func copyToClipBoard() {
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.setString(self.getCode(), forType: .string)

    }
    
    func filterMembersByRole(role: String) -> [String] {
        guard let roleId = roles[role] else {
            return []
        }

        let filteredMembers = workspaceMembers.compactMap { (_, members) -> [String]? in
            let filtered = members.filter { user in
                return user.id == roleId
            }.map { user in
                return user.name
            }
            return filtered.isEmpty ? nil : filtered
        }

        return Array(filteredMembers.joined())
    }
}
