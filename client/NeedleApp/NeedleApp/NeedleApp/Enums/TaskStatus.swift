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
            if self == .TODO {
                return "TO-DO"
            }
            else {
                return formatUpperCase(rawValue)
            }
    }
    
    var order: Int {
        switch self {
        case .TODO: return 0
        case .IN_PROGRESS: return 1
        case .PENDING: return 2
        case .DONE: return 3
        case .NOT_VISIBLE: return 4
        }
    }
}
