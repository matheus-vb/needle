//
//  KanbanFunctions.swift
//  NeedleApp
//
//  Created by Jpsmor on 23/08/23.
//

import SwiftUI

extension KanbanView {
    
    func addItem(currentlyDragging: String, status: TaskStatus) {
        if let sourceIndex = kanbanViewModel.localTasks.firstIndex(where: {
            $0.id == currentlyDragging
        }){
            var sourceItem = kanbanViewModel.localTasks.remove(at: sourceIndex)
            sourceItem.status = status
            kanbanViewModel.localTasks.append(sourceItem)
            TaskDataService.shared.updateTaskStatus(taskId: currentlyDragging, status: status, userId: AuthenticationManager.shared.user!.id, workspaceId: kanbanViewModel.selectedWorkspace.id)
        }
    }
    
    func swapItem(droppingTask: TaskModel, currentlyDragging: String) {
        if let sourceIndex = kanbanViewModel.localTasks.firstIndex(where: {
            $0.id == currentlyDragging
        }), let destinationIndex = kanbanViewModel.localTasks.firstIndex(where: {
            $0.id == droppingTask.id
        }) {
            var sourceItem = kanbanViewModel.localTasks.remove(at: sourceIndex)
            sourceItem.status = droppingTask.status
            kanbanViewModel.localTasks.insert(sourceItem, at: destinationIndex)
        }
    }
    
    func getPriorityFlagColor(priority: TaskPriority) -> Color {
        switch priority {
        case .HIGH:
            return Color.theme.redMain
        case .VERY_HIGH:
            return Color.theme.redMain
        case .MEDIUM:
            return Color.theme.orangeKanban
        case .LOW:
            return Color.theme.greenKanban
        }
    }
    
}
