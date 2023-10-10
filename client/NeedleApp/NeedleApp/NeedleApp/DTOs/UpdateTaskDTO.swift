//
//  UpdateTaskDTO.swift
//  NeedleApp
//
//  Created by Bof on 10/10/23.
//

import Foundation

struct UpdateTaskDTO: Codable {
    var taskId: String
    var title: String
    var description: String
    var stats: String
    var type: String
    var endDate: String
    var priority: String 
}
