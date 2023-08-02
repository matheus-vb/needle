//
//  CreateTaskViewModel.swift
//  NeedleApp
//
//  Created by jpcm2 on 26/07/23.
//

import Foundation

class CreateTaskViewModel: ObservableObject{
    @Published var taskDescription: String = "Adicione uma breve descrição do projeto"
    @Published var taskTitle: String = "Task 1"
    
    @Published var statusSelection: TaskStatus = .TODO
    @Published var prioritySelection: TaskPriority = .LOW
    @Published var deadLineSelection = Date.now
    @Published var categorySelection: String = "1"
    @Published var documentationString: NSAttributedString = NSAttributedString(string: "")
    
    let categoryOp = ["DEV", "DESIGN", "PM", "GENERAL"]
    
    // MARK: FALTA COLOCAR O USERID + ACCESSCODE
    func createTask(){
        let task: CreateTaskDTO
        task = CreateTaskDTO(userId: "1", accessCode: "1", title: self.taskTitle, description: self.taskDescription, stats: self.statusSelection.rawValue, type: self.categorySelection, endDate: self.deadLineSelection, priority: self.prioritySelection.rawValue)
        
        print(task)
    }
}
