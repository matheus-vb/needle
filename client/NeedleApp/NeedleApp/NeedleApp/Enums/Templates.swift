//
//  Templates.swift
//  NeedleApp
//
//  Created by jpcm2 on 08/08/23.
//

import Foundation

enum TemplateArea: String, CaseIterable {
    case general, design, dev
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
    case taskImplem = "TASKIMPLEM"
    case generalDev  = "GENERALDEV"
    case bugReport = "BUGREPORT"
    case simpleBack = "SIMPLEBACK"
    case prBack = "PRBACK"
    case simpleFront = "SIMPLEFRONT"
    
    var info: TemplateInfo {
        switch self {
            // general templates
        case .overview: return TemplateInfo(name: NSLocalizedString("", comment: ""), area: .general, img: "visualizer_placeholder")
            
            // design templates
        case .generalDesign: return TemplateInfo(name: NSLocalizedString("", comment: ""), area: .design, img: "visualizer_placeholder")
        case .doubleDiamond: return TemplateInfo(name: NSLocalizedString("", comment: ""), area: .design, img: "visualizer_placeholder")
            
            // dev templates
        case .taskImplem: return TemplateInfo(name: NSLocalizedString("", comment: ""), area: .dev, img: "visualizer_placeholder")
        case .generalDev: return TemplateInfo(name: NSLocalizedString("", comment: ""), area: .dev, img: "visualizer_placeholder")
        case .bugReport: return TemplateInfo(name: NSLocalizedString("", comment: ""), area: .dev, img: "visualizer_placeholder")
        case .simpleBack: return TemplateInfo(name: NSLocalizedString("", comment: ""), area: .dev, img: "visualizer_placeholder")
        case .prBack: return TemplateInfo(name: NSLocalizedString("", comment: ""), area: .dev, img: "visualizer_placeholder")
        case .simpleFront: return TemplateInfo(name: NSLocalizedString("", comment: ""), area: .dev, img: "visualizer_placeholder")
        }
    }
    
    var initialText: String {
        switch self {
            
            //TODO: replace strings w correct code
            
            // general templates
        case .overview: return NSLocalizedString("devTemplate", comment: "")
            
            // design templates
        case .generalDesign: return NSLocalizedString("devTemplate", comment: "")
        case .doubleDiamond: return NSLocalizedString("devTemplate", comment: "")
            
            // dev templates
        case .taskImplem: return NSLocalizedString("devTemplate", comment: "")
        case .generalDev: return NSLocalizedString("devTemplate", comment: "")
        case .bugReport: return NSLocalizedString("devTemplate", comment: "")
        case .simpleBack: return NSLocalizedString("devTemplate", comment: "")
        case .prBack: return NSLocalizedString("devTemplate", comment: "")
        case .simpleFront: return NSLocalizedString("devTemplate", comment: "")
        }
    }
}
