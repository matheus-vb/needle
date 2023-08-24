//
//  CreateTaskPopUp.swift
//  NeedleApp
//
//  Created by jpcm2 on 04/08/23.
//

import SwiftUI

struct CreateTaskPopUp: View {
    @ObservedObject var createTaskViewModel: CreateTaskViewModel
    var geometry: GeometryProxy
    
    init(geometry: GeometryProxy, members: [User], showPopUp: Binding<Bool>, selectedWorkspace: Workspace, selectedStatus: TaskStatus) {
        
        self.createTaskViewModel = CreateTaskViewModel(
            members: members,
            showPopUp: showPopUp,
            selectedWorkspace: selectedWorkspace,
            selectedStatus: selectedStatus
        )
        
        self.geometry = geometry
    }
    
    var body: some View {
        VStack(spacing: 24){
            topSection
            contentStack
        }
        .scrollIndicators(.hidden)
        .padding([.leading, .trailing], 64)
        .padding([.top, .bottom],32)
        .frame(width: 4*geometry.size.width/9.0, height: 19*geometry.size.height/20)
        .background(.white)
    }
}
