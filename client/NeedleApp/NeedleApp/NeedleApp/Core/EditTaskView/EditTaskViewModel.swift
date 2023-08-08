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
    @Published var statusSelection: TaskStatus
    @Published var prioritySelection: TaskPriority
    @Published var deadLineSelection: Date
    @Published var categorySelection: TaskType
    @Published var selectedMember: WorkspaceUser
    @Published var documentationString: NSAttributedString
    @Published var members: [WorkspaceUser] = [WorkspaceUser(id: "", name: "Joao Medeiros"), WorkspaceUser(id: "", name: "Bia Ferre"), WorkspaceUser(id: "", name: "Matheus Veras"), WorkspaceUser(id: "", name: "Vitoria Pinheir"), WorkspaceUser(id: "", name: "André Valença")]
    
    init(data: TaskModel) {
        let isoDateString = data.endDate
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions =  [.withInternetDateTime, .withFractionalSeconds]
        let date = formatter.date(from: isoDateString)
        self.taskDescription = data.description
        self.taskTitle = data.title
        self.statusSelection = TaskStatus(rawValue: data.status)!
        self.prioritySelection = data.taskPriority
        self.deadLineSelection = date!
        self.categorySelection = TaskType(rawValue: data.type)!
        self.selectedMember = WorkspaceUser(id: "1", name: "Medeiros")
        self.documentationString = NSAttributedString(string: data.document?.text ?? "")
    }
}
