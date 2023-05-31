//
//  TaskModel.swift
//  Needle
//

//  Created by gabrielfelipo on 26/05/23.

//  Created by matheusvb on 30/05/23.

//

import Foundation


enum TaskType: String, CaseIterable {
    case Dev = "dev"
    case Design = "design"
    case PM = "PM"
    
}

struct TaskModel: Identifiable {
    var id: String
    var type: TaskType
    var documentId: String
    var endDate: Date?
    var userId: String
}


struct SingleTaskResponse: Codable {
    let data: Task1
}

struct TaskResponse: Codable {
    let data: [Task1]
}

struct Task1: Codable, Identifiable {
    let id: String
    let title: String
    let description: String
    let status: String
    let type: String
    let documentId: String
    let endDate: String
    let workId: String
    let userId: String?
    let taskTag: String
}
