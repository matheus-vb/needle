//
//  ProjectViewModel.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//

import Foundation
import Combine
import SwiftUI

class ProjectViewModel<
    A: AuthenticationManagerProtocol & ObservableObject,
    T: TaskDataServiceProtocol & ObservableObject,
    W: WorkspaceDataServiceProtocol & ObservableObject
>: ObservableObject{
    @AppStorage("userID") var userID: String = "Default User"
    @Published var selectedTab: SelectedTab = .Kanban 
    @Published var selectedWorkspace: Workspace
    @Published var projects: [Workspace] = []
    
    @Published var tasks: [String:[TaskModel]] = [:]
    @Published var workspaceMembers: [String:[User]] = [:]
    @Published var roles: [String: Role] = [:]
    
    @Published var showPopUp: Bool = false
    @Published var showEditTaskPopUP: Bool = false
    @Published var selectedColumnStatus: TaskStatus = .TODO
    @Published var selectedTask: TaskModel?
    
    @Published var showCard: Bool = false
    
    @Published var showShareCode = false
    
    @Published var isAnimating = false
    
    var worskpaceDS: W
    var tasksDS: T
    var authMGR: A
    var cancellables = Set<AnyCancellable>()

    init(selectedWorkspace: Workspace, manager: A, taskDS: T, workspaceDS: W) {
        self.authMGR = manager
        self.tasksDS = taskDS
        self.worskpaceDS = workspaceDS
        
        self.selectedWorkspace = selectedWorkspace
        
        addSubscribers()
    }
    
    func getCode() -> String {
        return selectedWorkspace.accessCode
    }
    
    func addSubscribers() {
        worskpaceDS.workspacePublisher
            .sink(receiveValue: { [weak self] returnedWorkspaces in
                self?.projects = returnedWorkspaces
            })
            .store(in: &cancellables)
        
        tasksDS.allUsersTasksPublisher
            .sink(receiveValue: { [weak self] returnedTasks in
                self?.tasks = returnedTasks
            })
            .store(in: &cancellables)
        
        worskpaceDS.membersPublisher
            .sink(receiveValue: { [weak self] returnedUsers in
                self?.workspaceMembers = returnedUsers
                self?.$workspaceMembers.append(["":[User(id: "", name: "---", email: "", workspaces: [])]])
            })
            .store(in: &cancellables)
        
        authMGR.rolesPublihser
            .sink(receiveValue: { [weak self] returnedRoles in
                self?.roles = returnedRoles
            })
            .store(in: &cancellables)
    }
    
    func deleteTask(){
        tasksDS.deleteTask(dto: DeleteTaskDTO(taskId: selectedTask!.id), userId: userID, workspaceId: selectedWorkspace.id)
    }
    
    func getRoleInWorkspace(workspaceId: String) {
        authMGR.getRoleInWorkspace(userId: userID, workspaceId: workspaceId)
    }
    
    func getWorkspaceTasks(workspaceId: String) {
        tasksDS.getWorkspaceTasks(userId: userID, workspaceId: workspaceId)
    }
    
    func getWorkspaceMembers(workspaceId: String) {
        worskpaceDS.getWorkspaceMembers(workspaceId: workspaceId)
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
}
