//
//  Roles.swift
//  NeedleApp
//
//  Created by matheusvb on 08/08/23.
//

import Foundation

enum Role: String, CaseIterable, Codable {
    case PRODUCT_MANAGER = "PRODUCT_MANAGER"
    case DESIGNER = "DESIGNER"
    case DEVELOPER = "DEVELOPER"
    case QA = "QA"
    case BUSINESS = "BUSINESS"
    case DEVOPS = "DEVOPS"
    case SALES = "SALES"
    case MARKETING = "MARKETING"
}
