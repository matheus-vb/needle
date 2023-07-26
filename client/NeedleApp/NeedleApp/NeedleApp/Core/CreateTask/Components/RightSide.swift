//
//  RightSide.swift
//  NeedleApp
//
//  Created by jpcm2 on 26/07/23.
//

import SwiftUI

struct RightSide: View {
    let metrics: GeometryProxy
    var body: some View {
        VStack{
            
        }
        .frame(width: metrics.size.width*0.3, height: metrics.size.height)
        .background(.red)
    }
}
