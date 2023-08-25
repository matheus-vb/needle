//
//  KanbanViewModel.swift
//  NeedleApp
//
//  Created by matheusvb on 04/08/23.
//

import Foundation
import SwiftUI

class KanbanViewModel: ObservableObject {
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
    
    init(localTasks: [TaskModel], role: Role, selectedColumn: Binding<TaskStatus>, showPopUp: Binding<Bool>, showCard: Binding<Bool>, selectedWorkspace: Workspace, selectedTask: Binding<TaskModel?>, isEditing: Binding<Bool>) {
        self.localTasks = localTasks
        self.role = role
        self._selectedColumn = selectedColumn
        self._showPopUp = showPopUp
        self._showCard = showCard
        self.selectedWorkspace = selectedWorkspace
        self._selectedTask = selectedTask
        self._isEditing = isEditing
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
}
