//
//  EditTaskView.swift
//  NeedleApp
//
//  Created by jpcm2 on 08/08/23.
//

import SwiftUI

struct EditTaskPopUP: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var editTaskViewModel: EditTaskViewModel<TaskDataService>
    @State var chooseTemplate: Bool = false

    var navigate: () -> ()
    var geometry: GeometryProxy
            
    init(data: TaskModel, workspaceID: String, members: [User], isEditing: Binding<Bool>, geometry: GeometryProxy, navigate: @escaping () -> ()) {
        self.editTaskViewModel = EditTaskViewModel(data: data, workspaceID: workspaceID, members: members, isEditing: isEditing, taskDS: TaskDataService.shared)
        self.geometry = geometry
        self.navigate = navigate
        
    }
    
    var editTask: some View {
        VStack(spacing: 24){
            contentStack
                .padding(2)
        }
    }
    
    var body: some View {
        NavigationStack {
            if chooseTemplate {
                ChooseTemplateView(backAction: { chooseTemplate.toggle() }, closeAction: { editTaskViewModel.isEditing.toggle() }, goToDocumentationAction: { navigate() })
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
                .environmentObject(projectViewModel)
        })
        .scrollIndicators(.hidden)
        .padding([.leading, .trailing], 64)
        .padding([.top, .bottom],32)
        .frame(minWidth: 3*geometry.size.width/5, maxHeight: 19.5*geometry.size.height/20)
        .background(.white)
    }
    
    func openDocumentation() -> any View {
        if editTaskViewModel.selectedTask.document == nil {
            navigate()
        }
        return ChooseTemplateView(backAction: { chooseTemplate.toggle() }, closeAction: { editTaskViewModel.isEditing.toggle() }, goToDocumentationAction: { navigate() })
    }
}
