//
//  KanbanViewModel.swift
//  NeedleApp
//
//  Created by matheusvb on 04/08/23.
//

import Foundation
import SwiftUI

class KanbanViewModel<
    T: TaskDataServiceProtocol & ObservableObject
>: ObservableObject {
    @AppStorage("userID") var userID: String = "Default User"
    @Published var localTasks: [TaskModel]
    
    @Published var somethingBeingDragged = false
    @Published var currentlyDragging : String?
    @Published var currentlyTarget: String?
    @Published var isDeleting = false
    @Published var isArchiving = false
    
    @Binding var selectedTask: TaskModel?
    
    @Binding var selectedColumn: TaskStatus
    @Binding var showPopUp: Bool
    @Binding var showCard: Bool
    @Binding var isEditing: Bool
    
    let role: Role
    
    let selectedWorkspace: Workspace
    
    private var taskDS: T
    
    init(localTasks: [TaskModel], role: Role, selectedColumn: Binding<TaskStatus>, showPopUp: Binding<Bool>, showCard: Binding<Bool>, selectedWorkspace: Workspace, selectedTask: Binding<TaskModel?>, isEditing: Binding<Bool>, taskDS: T) {
        self.localTasks = localTasks
        self.role = role
        self._selectedColumn = selectedColumn
        self._showPopUp = showPopUp
        self._showCard = showCard
        self.selectedWorkspace = selectedWorkspace
        self._selectedTask = selectedTask
        self._isEditing = isEditing
        self.taskDS = taskDS
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
    
    func updateTaskStatus(taskId: String, status: TaskStatus) {
        taskDS.updateTaskStatus(taskId: taskId, status: status, userId: userID, workspaceId: selectedWorkspace.id)
    }
    
    func addItem(currentlyDragging: String, status: TaskStatus) {
        if let sourceIndex = self.localTasks.firstIndex(where: {
            $0.id == currentlyDragging
        }){
            var sourceItem = self.localTasks.remove(at: sourceIndex)
            sourceItem.status = status
            self.localTasks.append(sourceItem)
            self.updateTaskStatus(taskId: currentlyDragging, status: status)
        }
    }
    
    func swapItem(droppingTask: TaskModel, currentlyDragging: String) {
        if let sourceIndex = self.localTasks.firstIndex(where: {
            $0.id == currentlyDragging
        }), let destinationIndex = self.localTasks.firstIndex(where: {
            $0.id == droppingTask.id
        }) {
            var sourceItem = self.localTasks.remove(at: sourceIndex)
            sourceItem.status = droppingTask.status
            self.localTasks.insert(sourceItem, at: destinationIndex)
            self.updateTaskStatus(taskId: currentlyDragging, status: droppingTask.status)
        }
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
