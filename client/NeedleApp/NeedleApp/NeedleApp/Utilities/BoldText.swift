//
//  BoldText.swift
//  NeedleApp
//
//  Created by vivi on 12/09/23.
//

import SwiftUI

struct BoldText: View {
    let text: String
    
    var body: some View {
        let parts = text.components(separatedBy: "**")
        if parts.count > 1 {
            return AnyView(
                parts.enumerated().map { index, part in
                    if index % 2 == 0 {
                        return Text(part)
                            .font(.custom(SpaceGrotesk.regular.rawValue, size: 24))
                    } else {
                        return Text(part)
                            .font(.custom(SpaceGrotesk.bold.rawValue, size: 24))
                    }
                }.reduce(Text(""), +)
            )
        } else {
            return AnyView(Text(text))
        }
    }
}
