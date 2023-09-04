//
//  DocumentationView.swift
//  NeedleApp
//
//  Created by matheusvb on 24/08/23.
//

import SwiftUI
import RichTextKit

struct DocumentationView: View {
    @ObservedObject var documentationViewModel: DocumentationViewModel<DocumentationDataService>
    @ObservedObject var editTaskViewModel: EditTaskViewModel<DocumentationDataService, TaskDataService>

    @Environment(\.dismiss) var dismiss
    
    @Binding var documentationNS: NSAttributedString
    
    init(workspaceId: String, documentId: String, documentationNS: Binding<NSAttributedString>, editTaskViewModel: EditTaskViewModel<DocumentationDataService, TaskDataService>) {
        self.documentationViewModel = DocumentationViewModel(workspaceId: workspaceId, documentId: documentId, docDS: DocumentationDataService.shared)
        self.editTaskViewModel = editTaskViewModel
        self._documentationNS = documentationNS
    }
    
    var body: some View {
        VStack(alignment: .center) {
            taskDataHeader
            Spacer()
                HStack {
                    editor
                    leftBorder
                    toolbar
                }.background(Color.theme.grayBackground)
            Spacer()
            saveTask
            Spacer()
        }
    
    }
        
    var taskDataHeader: some View {
        VStack(alignment: .center, spacing: 32) {
            Text("\(editTaskViewModel.taskTitle)")
                .font(.system(size: 40, weight: .medium))
                .foregroundColor(.black)

            HStack(spacing: 48) {
                Spacer()
                HStack(spacing: 16) {
                    LabelComponent(imageName: "calendar", label: NSLocalizedString("Prazo", comment: ""))
                    Text("\(editTaskViewModel.selectedTask.endDate)")
                        .font(.system(size: 16, weight: .regular))

                }
                HStack(spacing: 16) {
                    LabelComponent(imageName: "person.fill", label:NSLocalizedString("Área", comment: ""))
                    Text("chato")
                        .font(.system(size: 16, weight: .regular))

                    //Text("\(editTaskViewModel.selectedTask.user?.name)")
                }
                HStack(spacing: 16) {
                    LabelComponent(imageName: "shippingbox", label:NSLocalizedString("Área", comment: ""))
                        .font(.system(size: 16, weight: .regular))

                    KanbanTagView(taskType: editTaskViewModel.selectedTask.type)
                    
                }
                HStack(spacing: 16) {
                    LabelComponent(imageName: "flag.fill", label: NSLocalizedString("Prioridade", comment: ""))
                        .font(.system(size: 16, weight: .regular))

                    Image(systemName: "flag.fill")
                        .font(Font.custom("SF Pro", size: 12))
                        .foregroundColor(documentationViewModel.getPriorityFlagColor(priority: editTaskViewModel.selectedTask.taskPriority))
                    
                }
                Spacer()
            }
            
        }
    }
    
    var editor: some View {
        RichTextEditor(text: $documentationNS, context: documentationViewModel.context) {
                $0.textContentInset = CGSize(width: 20, height: 40)
            }
        .focusedValue(\.richTextContext, documentationViewModel.context)
        }
        
        var toolbar: some View {
            VStack {
                RichTextFormatSidebar(context: documentationViewModel.context)
                    .layoutPriority(-1)
                    .foregroundColor(Color.theme.blackMain)
            }
        }
        
        var leftBorder: some View {
            HStack {
               Rectangle()
                   .frame(width: 2)
                   .foregroundColor(Color.theme.blackMain)
           }
        }
    
    var saveTask: some View{
        HStack{
            PopUpButton(text: NSLocalizedString("Cancelar", comment: ""), onButtonTapped: {
                editTaskViewModel.isEditing.toggle()
            })
            PopUpButton(text: NSLocalizedString("Salvar", comment: ""), onButtonTapped: saveTaskButton)
        }
    }
    
    func saveTaskButton(){
        let currDto = editTaskViewModel.dto
        TaskDataService.shared.saveTask(dto: editTaskViewModel.dto, userId: editTaskViewModel.userID, workspaceId: editTaskViewModel.workspaceID)
        editTaskViewModel.isEditing.toggle()
    }
}
