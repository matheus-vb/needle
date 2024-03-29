//
//  CreateTaskPopUp.swift
//  NeedleApp
//
//  Created by jpcm2 on 04/08/23.
//

import SwiftUI

struct CreateTaskPopUp: View {
    @ObservedObject var createTaskViewModel: CreateTaskViewModel<TaskDataService>
    @State var goToChooseDoc: Bool = false
    var geometry: GeometryProxy
    
    init(geometry: GeometryProxy, members: [User], showPopUp: Binding<Bool>, selectedWorkspace: Workspace, selectedStatus: TaskStatus) {
        
        self.createTaskViewModel = CreateTaskViewModel(
            members: members,
            showPopUp: showPopUp,
            selectedWorkspace: selectedWorkspace,
            selectedStatus: selectedStatus,
            taskDS: .shared
        )
        
        self.geometry = geometry
    }
    
    var body: some View {
        if !goToChooseDoc {
            VStack(spacing: 24){
                topSection
                contentStack
            }
            .scrollIndicators(.hidden)
            .padding([.leading, .trailing], 64)
            .padding([.top, .bottom],32)
            .frame(minWidth: 3*geometry.size.width/5, minHeight: 10*geometry.size.height/20, maxHeight: 19*geometry.size.height/20)
            .background(.white)
        } else {
            VStack{
                header
                Divider()
                content
            }.background(.white)
                .foregroundColor(.black)
                .frame(minWidth: 3*geometry.size.width/5,  minHeight: 10*geometry.size.height/20, maxHeight: 19*geometry.size.height/20)
        }
    }
}
