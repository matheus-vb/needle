//
//  EditTaskView.swift
//  NeedleApp
//
//  Created by jpcm2 on 08/08/23.
//

import SwiftUI

struct EditTaskPopUP: View {
    @ObservedObject var editTaskViewModel: EditTaskViewModel<TaskDataService>
    @State var seeDocumentation = false
    var geometry: GeometryProxy
    
    
    init(data: TaskModel, workspaceID: String, members: [User], isEditing: Binding<Bool>, geometry: GeometryProxy) {
        self.editTaskViewModel = EditTaskViewModel(data: data, workspaceID: workspaceID, members: members, isEditing: isEditing, taskDS: TaskDataService.shared)
        self.geometry = geometry
    }
    
    var body: some View {
        VStack(spacing: 24){
            contentStack
                .frame(maxWidth: geometry.size.width*0.29)
                .padding(2)
        }
        .overlay(content: {
            if editTaskViewModel.seeDocumentation {
                DocumentationView(workspaceId: editTaskViewModel.workspaceID, documentId: editTaskViewModel.documentationID, documentationNS: $editTaskViewModel.documentationString, editTaskViewModel: editTaskViewModel)

                    .background(.white)
            }
        })
        .popover(isPresented: $editTaskViewModel.isDeleting, content: {
            SheetView(type: .deleteTask)
                .foregroundColor(Color.theme.grayHover)
                .background(.white)
                .environmentObject(editTaskViewModel)
        })
        .scrollIndicators(.hidden)
        .padding([.leading, .trailing], 64)
        .padding([.top, .bottom],32)
        .frame(minWidth: 2*geometry.size.width/3, maxHeight: 19*geometry.size.height/20)
        .background(.white)
    }
}
