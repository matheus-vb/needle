//
//  EditTaskView.swift
//  NeedleApp
//
//  Created by jpcm2 on 08/08/23.
//

import SwiftUI

struct EditTaskPopUP: View {
    @ObservedObject var editTaskViewModel: EditTaskViewModel<TaskDataService>
    @State var seeDocumentation: Bool = false

    var geometry: GeometryProxy
            
    init(data: TaskModel, workspaceID: String, members: [User], isEditing: Binding<Bool>, geometry: GeometryProxy) {
        self.editTaskViewModel = EditTaskViewModel(data: data, workspaceID: workspaceID, members: members, isEditing: isEditing, taskDS: TaskDataService.shared)
        self.geometry = geometry
    }
    
    var editTask: some View {
        VStack(spacing: 24){
            contentStack
            //.frame(maxWidth: geometry.size.width*0.29)
                .padding(2)
        }
    }
    
    var body: some View {
        NavigationStack {
            if seeDocumentation {
//                if editTaskViewModel.documentationString == {
                ChooseTemplateView(backAction: { seeDocumentation.toggle() }, closeAction: { editTaskViewModel.isEditing.toggle() },goToDocumentationAction: {  })
//                }
            }
            else {
                editTask
            }
        }
        .popover(isPresented: $editTaskViewModel.isDeleting, content: {
            SheetView(type: .deleteTask)
                .foregroundColor(Color.theme.grayHover)
                .background(.white)
                .environmentObject(editTaskViewModel)
        })
        .scrollIndicators(.hidden)
        .padding([.leading, .trailing], 64)
        .padding([.top, .bottom],32)
        .frame(minWidth: 3*geometry.size.width/5, maxHeight: 19.5*geometry.size.height/20)
        .background(.white)
    }
}
