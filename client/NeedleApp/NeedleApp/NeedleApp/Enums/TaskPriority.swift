//
//  TaskPriority.swift
//  NeedleApp
//
//  Created by jpcm2 on 02/08/23.
//

import Foundation

enum TaskPriority: String, CaseIterable, Codable, CodingKeyRepresentable {
    case VERY_HIGH = "VERY_HIGH"
    case HIGH = "HIGH"
    case MEDIUM = "MEDIUM"
    case LOW = "LOW"
    
    var displayName: String {
        if rawValue == "VERY_HIGH" { return "Urgente" }
        if rawValue == "HIGH" { return "Alta" }
        if rawValue == "MEDIUM" { return "Moderada" }
        if rawValue == "LOW" { return "Baixa" }
        return formatUpperCase(rawValue)
    }
}
