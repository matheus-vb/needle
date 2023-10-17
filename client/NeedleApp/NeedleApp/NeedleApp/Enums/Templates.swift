//
//  Templates.swift
//  NeedleApp
//
//  Created by jpcm2 on 08/08/23.
//

import Foundation

enum TemplateArea: String, CaseIterable {
    case general, design, dev
    
    var areaName: String {
        switch self {
        case .general: return NSLocalizedString("Geral", comment: "")
        case .design: return NSLocalizedString("Design", comment: "")
        case .dev: return NSLocalizedString("Desenvolvimento", comment: "")

        }
    }
}

struct TemplateInfo {
    var name: String
    var area: TemplateArea
    var img: String

}

enum TemplateType: String, CaseIterable {
    
    case overview = "OVERVIEW"
    case generalDesign = "GENERAL_DESIGN"
    case doubleDiamond = "DOUBLE_DIAMOND"
    case generalDev  = "GENERALDEV"
    case bugReport = "BUGREPORT"
    
    var info: TemplateInfo {
        switch self {
            // general templates
        case .overview: return TemplateInfo(name: NSLocalizedString("Visão geral", comment: ""), area: .general, img: "ProjectOverview")
            
            // design templates
        case .generalDesign: return TemplateInfo(name: NSLocalizedString("Design geral", comment: ""), area: .design, img: "Design")
        case .doubleDiamond: return TemplateInfo(name: NSLocalizedString("Double Diamond", comment: ""), area: .design, img: "DoubleDiamond")
            
            // dev templates
        case .generalDev: return TemplateInfo(name: NSLocalizedString("Dev geral", comment: ""), area: .dev, img: "GeneralDev")
        case .bugReport: return TemplateInfo(name: NSLocalizedString("Bug report", comment: ""), area: .dev, img: "BugReport")
        }
    }
    
    var initialText: String {
        switch self {
            
            //TODO: replace strings w correct code
            
            // general templates
        case .overview: return NSLocalizedString("projectTemplate", comment: "")
            
            // design templates
        case .generalDesign: return NSLocalizedString("designTemplate", comment: "")
        case .doubleDiamond: return NSLocalizedString("doubleDiamondTemplate", comment: "")
            
            // dev templates
        case .generalDev: return NSLocalizedString("devTemplate", comment: "")
        case .bugReport: return NSLocalizedString("bugReportTemplate", comment: "")
        }
    }
}
