//
//  TaskType.swift
//  NeedleApp
//
//  Created by jpcm2 on 02/08/23.
//

import Foundation

enum TaskType: String, CaseIterable, Codable{
    case DEV = "DEV"
    case DESIGN = "DESIGN"
    case PM = "PM"
    case GENERAL = "GENERAL"
    case BUSINESS = "BUSINESS"
    case DEVOPS = "DEVOPS"
    case SALES = "SALES"
    case MARKETING = "MARKETING"
    case QA = "QA"
    
    var displayName: String {
<<<<<<< HEAD
        if rawValue == "DEV" { return "Desenvolvimento" }
        if rawValue == "DESIGN" { return "Design" }
        if rawValue == "PM" { return "Product Manager" }
        if rawValue == "GENERAL" { return "Geral" }
        if rawValue == "BUSINESS" { return "Negócios" }
        if rawValue == "DEVOPS" { return "Devops" }
        if rawValue == "SALES" { return "Vendas" }
        if rawValue == "MARKETING" { return "Marketing" }
=======
>>>>>>> develop
        if rawValue == "QA" { return "QA" }
        return formatUpperCase(rawValue)
    }
}
