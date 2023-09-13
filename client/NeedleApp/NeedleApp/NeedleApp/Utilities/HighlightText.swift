//
//  HighlightText.swift
//  NeedleApp
//
//  Created by vivi on 13/09/23.
//

import SwiftUI


struct HighlightedText: View {
    let text: String
    
    var body: some View {
        let parts = text.components(separatedBy: "__")
        if parts.count > 1 {
            return AnyView(
                parts.enumerated().map { index, part in
                    if index % 2 == 0 {
                        return Text(part)
                    } else {
                        return Text(part)
                            .background(Color.theme.greenMain) as! Text
                    }
                }.reduce(Text(""), +)
            )
        } else {
            return AnyView(Text(text))
        }
    }
}
