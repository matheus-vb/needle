//
//  CustomFontsExtension.swift
//  NeedleApp
//
//  Created by aaav on 04/08/23.
//

import SwiftUI

enum SpaceGrotesk: String {
    
    case bold = "SpaceGrotesk-Bold"
    case light = "SpaceGrotesk-Light"
    case medium = "SpaceGrotesk-Medium"
    case regular = "SpaceGrotesk-Regular"
    case semiBold = "SpaceGrotesk-SemiBold"
}

extension Font.TextStyle {
    var size: CGFloat {
            switch self {
            case .headline: return 80
            case .largeTitle: return 40
            case .title: return 24
            case .title2: return 18
            case .title3: return 16
            case .body: return 14
            case .subheadline, .callout: return 12
            case .footnote: return 12
            case .caption, .caption2: return 12
                
            @unknown default:
                return 12
            }
        }
}

extension Font {
    static func custom(_ font: SpaceGrotesk, relativeTo style: Font.TextStyle) -> Font {
        custom(font.rawValue, size: style.size, relativeTo: style)
    }
}
