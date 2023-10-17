//
//  EditTaskViewModel.swift
//  NeedleApp
//
//  Created by jpcm2 on 08/08/23.
//

import Foundation
import SwiftUI
import Combine
import RichTextKit

class EditTaskViewModel<
    T: TaskDataServiceProtocol & ObservableObject
>: ObservableObject{
    @AppStorage("userID") var userID: String = "Default User"
    private var cancellables = Set<AnyCancellable>()
    
    private var taskDS: T
    let selectedTask: TaskModel
    
    let context = RichTextContext()
    
    @Binding var isEditing: Bool
    @Published var userId: String?
    @Published var documentationID: String
    @Published var workspaceID: String
    @Published var taskId: String
    @Published var taskDescription: String
    @Published var taskTitle: String
    @Published var statusSelection: TaskStatus
    @Published var prioritySelection: TaskPriority
    @Published var deadLineSelection: Date
    @Published var categorySelection: TaskType
    @Published var selectedMember: User?
    @Published var documentationString: NSAttributedString
    @Published var members: [User]

    @Published var isDeleting: Bool = false
    @Published var isArchiving: Bool = false
    var dto: UpdateTaskDTO

    
    init(data: TaskModel, workspaceID: String, members: [User], isEditing: Binding<Bool>, taskDS: T) {
        self.selectedTask = data
        self._isEditing = isEditing
        let isoDateString = data.endDate
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions =  [.withInternetDateTime, .withFractionalSeconds]
        let date = formatter.date(from: isoDateString)
        self.workspaceID = workspaceID
        self.userId = data.userId
        self.taskId = data.id
        self.taskDescription = data.description
        self.taskTitle = data.title
        self.statusSelection = data.status
        self.prioritySelection = data.taskPriority
        self.deadLineSelection = date!
        self.categorySelection = data.type
        self.selectedMember = data.user
        self.documentationString = NSAttributedString(string: data.document?.text ?? "")
        self.documentationID = data.document?.id ?? "0"
        self.members = members
        self.taskDS = taskDS
        
        self.dto = UpdateTaskDTO(
            userId: data.userId,
            taskId: data.id,
            title: data.title,
            description: data.description,
            stats: data.status.rawValue,
            type: data.type.rawValue,
            endDate: data.endDate,
            priority: data.taskPriority.rawValue
        )
        
        self.setupBindings()

    }
    
    
    func setupBindings() {
        Publishers.CombineLatest4($userId, $taskId, $taskTitle, $taskDescription)
            .sink(receiveValue: { [weak self] (userId, taskId, taskTitle, taskDescription) in
                self?.dto.userId = userId
                self?.dto.taskId = taskId
                self?.dto.title = taskTitle
                self?.dto.description = taskDescription
            })
            .store(in: &cancellables)
        
        Publishers.CombineLatest4($statusSelection, $categorySelection, $deadLineSelection, $prioritySelection)
            .sink(receiveValue: { [weak self] (statusSelection, categorySelection, deadLineSelection, prioritySelection) in
                self?.dto.stats = statusSelection.rawValue
                self?.dto.type = categorySelection.rawValue
                self?.dto.endDate = "\(deadLineSelection)"
                self?.dto.priority = prioritySelection.rawValue
            })
            .store(in: &cancellables)

    }
    
    func saveTask(){
        taskDS.updateTask(dto: self.dto, userId: userID, workspaceId: self.workspaceID)
    }
    
    func archiveTask(){
        taskDS.updateTaskStatus(taskId: selectedTask.id, status: TaskStatus.NOT_VISIBLE, userId: userID, workspaceId: workspaceID)
    }
    
    func unarchiveTask(){
        taskDS.updateTaskStatus(taskId: selectedTask.id, status: TaskStatus.TODO, userId: userID, workspaceId: workspaceID)
    }

    
    func getPriorityFlagColor(priority: TaskPriority) -> Color {
        switch priority {
        case .HIGH:
            return Color.theme.redMain
        case .VERY_HIGH:
            return .purple
        case .MEDIUM:
            return Color.theme.orangeKanban
        case .LOW:
            return Color.theme.greenKanban
        }
    }
}
