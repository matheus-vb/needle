//
//  TaskModel.swift
//  Needle
//
//  Created by gabrielfelipo on 26/05/23.
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


