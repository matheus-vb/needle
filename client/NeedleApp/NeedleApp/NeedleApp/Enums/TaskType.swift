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
        if rawValue == "DEV" { return NSLocalizedString("Desenvolvimento", comment: "")}
        if rawValue == "DESIGN" { return NSLocalizedString("Design", comment: "") }
        if rawValue == "PM" { return NSLocalizedString("Product Manager", comment: "") }
        if rawValue == "GENERAL" { return NSLocalizedString("Geral", comment: "") }
        if rawValue == "BUSINESS" { return NSLocalizedString("Negócios", comment: "") }
        if rawValue == "DEVOPS" { return NSLocalizedString("DevOps", comment: "") }
        if rawValue == "SALES" { return NSLocalizedString("Vendas", comment: "") }
        if rawValue == "MARKETING" { return NSLocalizedString("Marketing", comment: "") }
        if rawValue == "QA" { return NSLocalizedString("QA", comment: "") }
        return formatUpperCase(rawValue)
    }
}
