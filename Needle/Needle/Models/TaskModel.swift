//
//  TaskModel.swift
//  Needle
//
//  Created by matheusvb on 30/05/23.
//

import Foundation

struct TaskResponse {
    let data: [Task]
}

struct Task: Codable, Identifiable {
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
