//
//  CreateTaskPopUp.swift
//  NeedleApp
//
//  Created by jpcm2 on 04/08/23.
//

import SwiftUI

struct CreateTaskPopUp: View {
    @StateObject var createTaskViewModel: CreateTaskViewModel = CreateTaskViewModel()
    @EnvironmentObject var projectViewModel: ProjectViewModel
    @EnvironmentObject var kanbanViewModel: KanbanViewModel
    var geometry: GeometryProxy
    var body: some View {
        ScrollView{
            VStack(spacing: 24){
                topSection
                contentStack
            }
        }
        .scrollIndicators(.hidden)
        .padding([.leading, .trailing], 64)
        .padding([.top, .bottom],32)
        .frame(width: 4*geometry.size.width/9.0, height: geometry.size.height)
        .background(.white)
    }
}
