//
//  CreateTaskView.swift
//  NeedleApp
//
//  Created by jpcm2 on 26/07/23.
//

import SwiftUI

struct CreateTaskView: View {
    var body: some View {
        GeometryReader{metrics in
            HStack(spacing: 0){
                LeftSide(metrics: metrics)
                RightSide(metrics: metrics)
            }
        }
    }
}

struct CreateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTaskView()
    }
}
