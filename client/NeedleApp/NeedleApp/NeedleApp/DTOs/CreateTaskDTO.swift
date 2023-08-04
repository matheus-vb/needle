//
//  CreateTaskDTO.swift
//  NeedleApp
//
//  Created by jpcm2 on 28/07/23.
//

import Foundation

struct CreateTaskDTO: Codable {
    let userId: String?
    let accessCode: String
    let title: String
    let description: String
    let stats: TaskStatus
    let type: TaskType
    let endDate: Date
    let priority: TaskPriority
}
