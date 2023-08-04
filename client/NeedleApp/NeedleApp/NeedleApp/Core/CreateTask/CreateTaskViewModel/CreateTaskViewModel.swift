//
//  CreateTaskViewModel.swift
//  NeedleApp
//
//  Created by jpcm2 on 26/07/23.
//

import Foundation

class CreateTaskViewModel: ObservableObject{
    @Published var taskDescription: String = "Adicione uma breve descrição do projeto"
    @Published var taskTitle: String = "Nome da Task"
    
    @Published var statusSelection: TaskStatus = .TODO
    @Published var prioritySelection: TaskPriority = .LOW
    @Published var deadLineSelection = Date.now
    @Published var categorySelection: TaskType = .GENERAL
    @Published var selectedMember: WorkspaceUser = WorkspaceUser(id: "", name: "")
    @Published var documentationString: NSAttributedString = NSAttributedString(string: "")
        
    @Published var members: [WorkspaceUser] = [WorkspaceUser(id: "", name: "Joao Medeiros"), WorkspaceUser(id: "", name: "Bia Ferre"), WorkspaceUser(id: "", name: "Matheus Veras"), WorkspaceUser(id: "", name: "Vitoria Pinheir"), WorkspaceUser(id: "", name: "André Valença")]
    
    // MARK: FALTA COLOCAR O USERID + ACCESSCODE
//    func createTask(){
//        let task: CreateTaskDTO
//        task = CreateTaskDTO(userId: selectedMember.id, accessCode: "1", title: self.taskTitle, description: self.taskDescription, stats: self.statusSelection.rawValue, type: self.categorySelection.rawValue, endDate: self.deadLineSelection, priority: self.prioritySelection.rawValue)
//
//        print(task)
//    }
}
