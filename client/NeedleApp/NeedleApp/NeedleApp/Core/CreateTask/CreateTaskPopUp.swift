//
//  CreateTaskPopUp.swift
//  NeedleApp
//
//  Created by jpcm2 on 04/08/23.
//

import SwiftUI

struct CreateTaskPopUp: View {
    @StateObject var createTaskViewModel: CreateTaskViewModel = CreateTaskViewModel()
    var geometry: GeometryProxy
    var body: some View {
        ScrollView{
            VStack(spacing: 30){
                taskTitle
                attributesStack
                description
                Spacer()
            }
        }
        .scrollIndicators(.hidden)
        .padding(64)
        .frame(width: geometry.size.width/3.0, height: geometry.size.height)
        .background(.white)
    }
}
