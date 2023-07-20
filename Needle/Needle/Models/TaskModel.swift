//
//  TaskModel.swift
//  Needle
//

//  Created by gabrielfelipo on 26/05/23.

//  Created by matheusvb on 30/05/23.

//

import Foundation

struct SingleTaskResponse: Codable {
    let data: TaskModel
}

struct TaskResponse: Codable {
    let data: [TaskModel]
}

struct TaskModel: Codable, Identifiable {
    let id: String?
    var title: String
    var description: String
    var status: String
    var type: String
    let documentId: String?
    var endDate: String
    let workId: String
    var userId: String?
}
