//
//  CreateTaskViewModel.swift
//  NeedleApp
//
//  Created by jpcm2 on 26/07/23.
//

import Foundation

class CreateTaskViewModel: ObservableObject{
    @Published var taskDescription: String = "Adicione uma breve descrição da tarefa"
    @Published var taskTitle: String = "Nome da Task"
    
    @Published var statusSelection: TaskStatus = .TODO
    @Published var prioritySelection: TaskPriority = .LOW
    @Published var deadLineSelection = Date.now
    @Published var categorySelection: TaskType = .GENERAL
    @Published var selectedMemberId: String = ""
    @Published var documentationString: NSAttributedString = NSAttributedString(string: "")
    
    @Published var members: [User]
    
    init(members: [User]) {
        self.members = members
    }
}
