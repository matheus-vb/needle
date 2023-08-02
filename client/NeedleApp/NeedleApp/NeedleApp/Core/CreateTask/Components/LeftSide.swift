//
//  LeftSide.swift
//  NeedleApp
//
//  Created by jpcm2 on 26/07/23.
//

import SwiftUI

struct LeftSide: View {
    @EnvironmentObject var createTaskViewModel: CreateTaskViewModel
    let metrics: GeometryProxy
    
    @State var atDescription: Bool = true
    @State var atTemplate: Bool = false
    
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 25){
                title
                buttonsContainer
                contentScreen
                Spacer()
            }
            .padding([.leading, .top], 124)
        }
        .frame(width: metrics.size.width*0.7, height: metrics.size.height)
        .background(.blue)
    }
}
