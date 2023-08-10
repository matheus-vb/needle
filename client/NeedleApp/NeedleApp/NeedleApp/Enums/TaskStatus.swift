//
//  TaskStatus.swift
//  NeedleApp
//
//  Created by jpcm2 on 02/08/23.
//

import Foundation

enum TaskStatus: String, CaseIterable, Codable {
    case TODO = "TODO"
    case IN_PROGRESS = "IN_PROGRESS"
    case PENDING = "PENDING"
    case DONE = "DONE"
    case NOT_VISIBLE = "NOT_VISIBLE"
    
    var displayName: String {
        return formatUpperCase(rawValue)
    }
}
