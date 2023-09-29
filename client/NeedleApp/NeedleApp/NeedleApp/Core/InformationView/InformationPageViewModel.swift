//
//  InformationPageViewModel.swift
//  NeedleApp
//
//  Created by aaav on 06/09/23.
//

import Foundation
import Combine
import SwiftUI

extension String{
    static var selectedMemberId : String = ""
}

class InformationPageViewModel< T: TaskDataServiceProtocol & ObservableObject, W: WorkspaceDataServiceProtocol & ObservableObject, A: AuthenticationManagerProtocol & ObservableObject >: ObservableObject{

    let workspace : Workspace
    @Published var tasks: [TaskModel]
    @Published var workspaceMembers: [User]
    @Published var sortOrder = [KeyPathComparator(\User.name)]
    @ObservedObject var authManager: A
    var workspaceDS: W
    private var taskDS: T
    private var cancellables = Set<AnyCancellable>()
    
    init(tasks: [TaskModel], workspaceMembers: [User], workspace: Workspace, workspaceDS: W, taskDS: T, authManager: A) {
        self.workspace = workspace
        self.tasks = tasks
        self.workspaceMembers = workspaceMembers
        self.workspaceDS = workspaceDS
        self.authManager = authManager
        self.taskDS = taskDS
        
        addSubscribers()
    }
    
    
    private func addSubscribers() {
        taskDS.allUsersTasksPublisher
            .sink(receiveValue: { [weak self] returnedTasks in
                self?.tasks = returnedTasks[self!.workspace.id] ?? []
            })
            .store(in: &cancellables)
        
        workspaceDS.membersPublisher
            .sink(receiveValue: { [weak self] returnedUsers in
                self?.workspaceMembers = returnedUsers[self!.workspace.id] ?? []
            })
            .store(in: &cancellables)
        
    }
    
    func updateSelectedMemberId(memberId: String){
        String.selectedMemberId = memberId
        print("already there: \(String.selectedMemberId), receiving \(memberId)")
        
    }
    func getMemberId() -> String{
        return String.selectedMemberId
    }
    
    func removeMember(){
        workspaceDS.deleteWorkspaceMember(userId: String.selectedMemberId, workspaceId: self.workspace.id)
    }
    
    func deleteWorkspace(){
        workspaceDS.deleteWorkspace(accessCode: workspace.accessCode, userId: authManager.user?.id ?? "")
    }
    
}
