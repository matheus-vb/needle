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
    
    @Published var statusSelection: String = "1"
    @Published var prioritySelection: String = "1"
    @Published var deadLineSelection = Date.now
    @Published var categorySelection: String = "1"
    
    let statusOp = ["TODO", "IN_PROGRESS", "PENDING", "DONE"]
    let priorityOp = ["1", "2", "3"]
    let categoryOp = ["DEV", "DESIGN", "PM", "GENERAL"]
    
    func createTask(){
        let task: CreateTaskDTO
        task = CreateTaskDTO(userId: "1", accessCode: "1", title: self.taskTitle, description: self.taskDescription, stats: self.statusSelection, type: self.categorySelection, endDate: self.deadLineSelection, priority: self.prioritySelection)
        
        print(task)
    }
}
