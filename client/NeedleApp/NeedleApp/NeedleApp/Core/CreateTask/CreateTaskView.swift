//
//  CreateTaskView.swift
//  NeedleApp
//
//  Created by jpcm2 on 26/07/23.
//

import SwiftUI

struct CreateTaskView: View {
    @StateObject var createTaskViewModel: CreateTaskViewModel = CreateTaskViewModel()
    var body: some View {
        GeometryReader{metrics in
            HStack(spacing: 0){
                LeftSide(metrics: metrics)
                    .environmentObject(createTaskViewModel)
                RightSide(metrics: metrics)
                    .environmentObject(createTaskViewModel)
            }
        }
    }
}

struct CreateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTaskView()
    }
}
