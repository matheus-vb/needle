//
//  EditTaskViewModel.swift
//  NeedleApp
//
//  Created by jpcm2 on 08/08/23.
//

import Foundation

class EditTaskViewModel: ObservableObject{
    @Published var taskDescription: String
    @Published var taskTitle: String
    @Published var statusSelection: TaskStatus = .TODO
    @Published var prioritySelection: TaskPriority = .LOW
    @Published var deadLineSelection = Date.now
    @Published var categorySelection: TaskType = .GENERAL
    @Published var selectedMember: WorkspaceUser = WorkspaceUser(id: "", name: "")
    @Published var documentationString: NSAttributedString = NSAttributedString(string: "")
    @Published var members: [WorkspaceUser] = [WorkspaceUser(id: "", name: "Joao Medeiros"), WorkspaceUser(id: "", name: "Bia Ferre"), WorkspaceUser(id: "", name: "Matheus Veras"), WorkspaceUser(id: "", name: "Vitoria Pinheir"), WorkspaceUser(id: "", name: "André Valença")]
    
    init(taskDescription: String, taskTitle: String, statusSelection: TaskStatus, prioritySelection: TaskPriority, deadLineSelection: Foundation.Date = Date.now, categorySelection: TaskType, selectedMember: WorkspaceUser, documentationString: NSAttributedString) {
        self.taskDescription = taskDescription
        self.taskTitle = taskTitle
        self.statusSelection = statusSelection
        self.prioritySelection = prioritySelection
        self.deadLineSelection = deadLineSelection
        self.categorySelection = categorySelection
        self.selectedMember = selectedMember
        self.documentationString = documentationString
    }
}
