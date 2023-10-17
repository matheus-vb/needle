//
//  SearchDocumentsViewModel.swift
//  NeedleApp
//
//  Created by matheusvb on 08/08/23.
//

import Foundation
import Combine
import SwiftUI

class SearchDocumentsViewModel<W: WorkspaceDataServiceProtocol & ObservableObject, T: TaskDataServiceProtocol & ObservableObject, A: AuthenticationManagerProtocol & ObservableObject, N: NotificationDataService & ObservableObject>: ObservableObject {
    let workspaceId: String
    @Published var workspaceMembers: [User] = []
    @Published var tasks: [TaskModel]
    @Published var userTasks: [TaskModel] = []
    @Published var selectedTaskID: TaskModel.ID?
    @Binding var selectedTask: TaskModel?
    @Binding var isEditing: Bool
    @Published var selectedStatus: TaskStatus? = nil
    @Published var selectedArea: TaskType? = nil
    @Published var selectedPriority: TaskPriority? = nil
    @Published var query: String? = nil
    @Published var currDTO: QueryTasksDTO
    @Published var sortOrder = [KeyPathComparator(\TaskModel.title)]
    @Published var workspaceNotifications : [NotificationModel] = []
    
    private var workspaceDS: W
    private var taskDS: T
    private var authManager: A
    private var notificationDS: N

    private var cancellables = Set<AnyCancellable>()
    
    init(tasks: [TaskModel], workspaceId: String, selectedTask: Binding<TaskModel?>, isEditing: Binding<Bool>, taskDS: T, authManager: A, notificationDS: N, workspaceDS: W) {
        self.taskDS = taskDS
        self.authManager = authManager
        self.notificationDS = notificationDS
        self.workspaceDS = workspaceDS
        self.tasks = tasks
        self.workspaceId = workspaceId
        self.currDTO = QueryTasksDTO(
            workspaceId: workspaceId,
            query: nil,
            status: nil,
            area: nil,
            priority: nil
        )
        self._selectedTask = selectedTask
        self._isEditing = isEditing
        
        addSubscribers()
        setupBindings()
        
        taskDS.queryTasks(dto: currDTO)
    }
    
    private func addSubscribers() {
        taskDS.queriedTasksPublihser
            .sink(receiveValue: { [weak self] returnedTasks in
                self?.tasks = returnedTasks
                self?.userTasks = returnedTasks.filter { $0.user?.id == self?.authManager.user?.id }
            })
            .store(in: &cancellables)
        
        notificationDS.workspaceNotificationsPublisher
            .sink(receiveValue: { [weak self] returnedNotifications in
                self?.workspaceNotifications = returnedNotifications
            })
            .store(in: &cancellables)
        
        
        workspaceDS.membersPublisher
            .sink(receiveValue: { [weak self] returnedUsers in
                self?.workspaceMembers = returnedUsers[self!.workspaceId] ?? []
            })
            .store(in: &cancellables)
    }
    
    private func setupBindings() {
        Publishers.CombineLatest4($query, $selectedStatus, $selectedArea, $selectedPriority)
            .sink(receiveValue: { [weak self] (query, selectedStatus, selectedArea, selectedPriority) in
                self?.currDTO = QueryTasksDTO(
                    workspaceId: self!.workspaceId,
                    query: query,
                    status: selectedStatus?.rawValue,
                    area: selectedArea?.rawValue,
                    priority: selectedPriority?.rawValue
                )
                
                self?.taskDS.queryTasks(dto: self!.currDTO)

            })
            .store(in: &cancellables)
    }
    
    func getUserID() -> String {
        return authManager.user?.id ?? ""
    }
    
    func deleteUserNotification(){
        print("deletei")
        print(authManager.user!.id)
        self.notificationDS.deleteUserNotifications(userId: authManager.user!.id)
    }
    
    func getWorkspaceNotifications(){
        self.notificationDS.getUserNotifications(userId: authManager.user!.id)
    }
    
    func getUserNameById(id: String) -> String{
        return workspaceMembers.filter{$0.id == id}[0].name
    }
    
}
