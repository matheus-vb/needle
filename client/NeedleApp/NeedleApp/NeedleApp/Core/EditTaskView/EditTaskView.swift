//
//  EditTaskView.swift
//  NeedleApp
//
//  Created by jpcm2 on 08/08/23.
//

import SwiftUI

struct EditTaskPopUP: View {
    @ObservedObject var editTaskViewModel: EditTaskViewModel<DocumentationDataService, TaskDataService>
    var geometry: GeometryProxy
    
    init(data: TaskModel, workspaceID: String, members: [User], isEditing: Binding<Bool>, geometry: GeometryProxy) {
        self.editTaskViewModel = EditTaskViewModel(data: data, workspaceID: workspaceID, members: members, isEditing: isEditing, documentationDS: DocumentationDataService.shared, taskDS: TaskDataService.shared)
        self.geometry = geometry
    }
    
    var body: some View {
        VStack(spacing: 24){
            topSection
            contentStack
        }
        .popover(isPresented: $editTaskViewModel.isDeleting, content: {
            SheetView(type: .deleteTask)
                .foregroundColor(Color.theme.grayHover)
                .background(.white)
        })
        .scrollIndicators(.hidden)
        .padding([.leading, .trailing], 64)
        .padding([.top, .bottom],32)
        .frame(width: 2*geometry.size.width/3, height: 19*geometry.size.height/20)
        .background(.white)
    }
}
