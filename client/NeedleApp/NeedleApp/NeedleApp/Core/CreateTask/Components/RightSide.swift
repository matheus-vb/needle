//
//  RightSide.swift
//  NeedleApp
//
//  Created by jpcm2 on 26/07/23.
//

import SwiftUI

struct RightSide: View {
    let metrics: GeometryProxy
    
    let statusOp = ["1", "2", "3"]
    @State var statusSelection: String = "1"
    @State var prioritySelection: String = "1"
    @State var deadLineSelection = Date.now
    
    var body: some View {
        VStack(alignment: .leading, spacing: 80){
            titleSection
            pickersSection
            Spacer()
        }
        .padding([.top], 124)
        .padding([.leading], 87)
        .padding([.trailing], 50)
        .frame(width: metrics.size.width*0.3, height: metrics.size.height)
        .background(.red)
    }
}
