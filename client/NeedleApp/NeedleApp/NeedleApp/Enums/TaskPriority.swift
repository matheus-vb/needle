//
//  TaskPriority.swift
//  NeedleApp
//
//  Created by jpcm2 on 02/08/23.
//

import Foundation

let priorityOp = ["VERY_HIGH", "HIGH", "MEDIUM", "LOW"]

enum TaskPriority: String, CaseIterable{
    case VERY_HIGH = "VERY_HIGH"
    case HIGH = "HIGH"
    case MEDIUM = "MEDIUM"
    case LOW = "LOW"
}
