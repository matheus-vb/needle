//
//  RightSide.swift
//  NeedleApp
//
//  Created by jpcm2 on 26/07/23.
//

import SwiftUI

struct RightSide: View {
    @EnvironmentObject var createTaskViewModel: CreateTaskViewModel
    let metrics: GeometryProxy
    
    var body: some View {
        VStack(alignment: .leading, spacing: 80){
            titleSection
            pickersSection
            Spacer()
            buttonsSection
        }
        .padding([.top], 124)
        .padding([.leading], 87)
        .padding([.trailing], 50)
        .frame(width: metrics.size.width*0.3, height: metrics.size.height)
        .background(.red)
    }
}
