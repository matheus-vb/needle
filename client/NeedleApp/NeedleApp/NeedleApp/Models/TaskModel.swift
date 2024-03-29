//
//  Task.swift
//  Needle
//
//  Created by jpcm2 on 26/07/23.
//

import Foundation

struct TaskModel: Codable, Identifiable {
    let id: String
    var title: String
    var description: String
    var status: TaskStatus
    var isRejected : Bool
    var isVisible : Bool
    var type: TaskType
    let documentId: String?
    var endDate: String
    let workId: String
    var userId: String?
    let taskPriority: TaskPriority
    let document: Document?
    let user: User?
    let created_at: String
    let updated_at: String
}
