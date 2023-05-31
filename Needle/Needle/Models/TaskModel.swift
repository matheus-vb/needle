//
//  TaskModel.swift
//  Needle
//

//  Created by gabrielfelipo on 26/05/23.

//  Created by matheusvb on 30/05/23.

//

import Foundation

struct SingleTaskResponse: Codable {
    let data: Task
}

struct TaskResponse: Codable {
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
