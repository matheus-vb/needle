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
    
//    static var shared : InformationPageViewModel
    let workspaceId: String
    let workspaceName: String
    @Published var tasks: [TaskModel]
    @Published var workspaceMembers: [User]
    @Published var sortOrder = [KeyPathComparator(\User.name)]
//    @Published var selectedMemberId: String = ""
    
    @ObservedObject var authManager: A
    var workspaceDS: W
    private var taskDS: T
    private var cancellables = Set<AnyCancellable>()
    
    init(tasks: [TaskModel], workspaceMembers: [User], workspaceId: String, workspaceName: String, workspaceDS: W, taskDS: T, authManager: A) {
        self.workspaceId = workspaceId
        self.workspaceName = workspaceName
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
                self?.tasks = returnedTasks[self!.workspaceId] ?? []
            })
            .store(in: &cancellables)
        
        workspaceDS.membersPublisher
            .sink(receiveValue: { [weak self] returnedUsers in
                self?.workspaceMembers = returnedUsers[self!.workspaceId] ?? []
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
        workspaceDS.deleteWorkspaceMember(userId: String.selectedMemberId, workspaceId: self.workspaceId)
    }
    
}
