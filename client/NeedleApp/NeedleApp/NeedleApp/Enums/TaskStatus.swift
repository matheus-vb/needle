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
    
    var displayName: String {
        return formatUpperCase(rawValue)
    }
}
