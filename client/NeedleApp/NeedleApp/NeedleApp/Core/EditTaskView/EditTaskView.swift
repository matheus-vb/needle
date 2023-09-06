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
            topSection
            contentStack
        }
        .overlay(content: {
            if seeDocumentation {
                DocumentationView(workspaceId: editTaskViewModel.workspaceID, documentId: editTaskViewModel.documentationID, documentationNS: $editTaskViewModel.documentationString, editTaskViewModel: editTaskViewModel, seeDocumentation: $seeDocumentation)
                    .environmentObject(editTaskViewModel)
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
        .frame(width: 2*geometry.size.width/3, height: 19*geometry.size.height/20)
        .background(.white)
    }
}
