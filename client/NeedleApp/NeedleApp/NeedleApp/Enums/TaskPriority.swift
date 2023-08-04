//
//  TaskPriority.swift
//  NeedleApp
//
//  Created by jpcm2 on 02/08/23.
//

import Foundation

enum TaskPriority: String, CaseIterable, Codable {
    case VERY_HIGH = "VERY_HIGH"
    case HIGH = "HIGH"
    case MEDIUM = "MEDIUM"
    case LOW = "LOW"
}
