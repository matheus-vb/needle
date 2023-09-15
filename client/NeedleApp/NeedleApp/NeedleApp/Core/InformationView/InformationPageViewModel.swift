//
//  InformationPageViewModel.swift
//  NeedleApp
//
//  Created by aaav on 06/09/23.
//

import Foundation
import Combine
import SwiftUI

class InformationPageViewModel< T: TaskDataServiceProtocol & ObservableObject, W: WorkspaceDataServiceProtocol & ObservableObject >: ObservableObject{
    let workspaceId: String
    @Published var tasks: [TaskModel]
    @Published var workspaceMembers: [String:[User]]
//    @Published var sortOrder = [KeyPathComparator(\User.name)]

    private var workspaceDS: W
    private var taskDS: T
    private var cancellables = Set<AnyCancellable>()

    init(tasks: [TaskModel], workspaceMembers: [String:[User]], workspaceId: String, workspaceDS: W, taskDS: T) {
        self.workspaceId = workspaceId
        self.tasks = tasks
        self.workspaceMembers = workspaceMembers
        self.workspaceDS = workspaceDS
        self.taskDS = taskDS
        
        addSubscribers()
//        setupBindings()
        
//        TaskDataService.shared.queryTasks(dto: currDTO)
    }
    
    
    private func addSubscribers() {
        taskDS.queriedTasksPublihser
            .sink(receiveValue: { [weak self] returnedTasks in
                self?.tasks = returnedTasks
            })
            .store(in: &cancellables)
        
        workspaceDS.membersPublisher
            .sink(receiveValue: { [weak self] returnedUsers in
                self?.workspaceMembers = returnedUsers
            })
            .store(in: &cancellables)
        
    }
    
    // USER ROLE IN WORKSPACE *
    
    // TOTAL NUMBER OF TASKS *
    
    // DONE TASKS IN WORKSPACE *
    
    // MEMBERS IN WORKSPACE *
        // NAME
        // ROLE
        // LAST ACCESS
        // STATUS
    
}
