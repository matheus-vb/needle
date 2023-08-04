//
//  Task.swift
//  Needle
//
//  Created by jpcm2 on 26/07/23.
//

import Foundation

struct TaskModel: Codable {
    let id: String?
    var title: String
    var description: String
    var status: String
    var type: String
    let documentId: String?
    var endDate: String
    let workId: String
    var userId: String?
    let document: Document?
}
