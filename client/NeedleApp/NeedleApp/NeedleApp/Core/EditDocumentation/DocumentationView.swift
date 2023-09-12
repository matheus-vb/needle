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
    @ObservedObject var editTaskViewModel: EditTaskViewModel<TaskDataService>
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var documentationNS: NSAttributedString
    
    init(workspaceId: String, documentId: String, documentationNS: Binding<NSAttributedString>, editTaskViewModel: EditTaskViewModel<TaskDataService>) {
        self.documentationViewModel = DocumentationViewModel(workspaceId: workspaceId, documentId: documentId, docDS: DocumentationDataService.shared)
        self.editTaskViewModel = editTaskViewModel
        self._documentationNS = documentationNS
    }
    
    var body: some View {
        VStack(alignment: .center) {
                taskDataHeader.padding(.top, 20)
                Spacer()
                HStack {
                    editor
                    leftBorder
                    toolbar
                }.background(Color.theme.grayBackground)
            HStack {
                Spacer()
                LabelComponent(imageName: "checkmark.icloud", label: NSLocalizedString("Alterações salvas automaticamente", comment: ""))
                    .foregroundColor(Color.theme.grayPressed)
                    .font(.system(size: 10))
            }
                Spacer()
        }.onDisappear(perform: {
//            documentationViewModel.getUpdate(data: UpdateDocumentationDTO(id: documentationViewModel.documentId, text: editTaskViewModel.selectedTask.document!.text, textString: editTaskViewModel.selectedTask.document!.textString), userId: editTaskViewModel.userID, workspaceId: editTaskViewModel.workspaceID)
        })
            
        }
        
        var taskDataHeader: some View {
            VStack(alignment: .center, spacing: 32) {
                HStack {
                    Button(action: {editTaskViewModel.seeDocumentation.toggle()}, label: {
                        LabelComponent(imageName: "arrow.backward", label: NSLocalizedString("", comment: ""))
                            .font(.system(size: 20, weight: .medium))
                    }).buttonStyle(.borderless)
                    Spacer()
                        Text("\(editTaskViewModel.taskTitle)")
                            .font(.system(size: 38, weight: .medium))
                            .foregroundColor(.black)
                    Spacer()
                }
                
                HStack(spacing: 48) {
                    HStack(spacing: 12) {
                        LabelComponent(imageName: "calendar", label: NSLocalizedString("Prazo", comment: ""))
                        Text("\(HandleDate.formatDateWithoutTime(dateInput: editTaskViewModel.selectedTask.endDate))")
                            .font(.system(size: 16, weight: .regular))
                        
                    }
                    HStack(spacing: 12) {
                        LabelComponent(imageName: "shippingbox", label:NSLocalizedString("Área", comment: ""))
                        KanbanTagView(taskType: editTaskViewModel.selectedTask.type)
                    }
                    HStack(spacing: 12) {
                        LabelComponent(imageName: "person.fill", label:NSLocalizedString("Responsável", comment: ""))
                            .font(.system(size: 16, weight: .regular))
                        
                        Text(editTaskViewModel.selectedTask.user?.name ?? NSLocalizedString("Sem responsável.", comment: ""))
                            .font(.system(size: 16, weight: .regular))
                        
                    }
                    HStack(spacing: 12) {
                        LabelComponent(imageName: "flag.fill", label: NSLocalizedString("Prioridade", comment: ""))
                            .font(.system(size: 16, weight: .regular))
                        
                            switch editTaskViewModel.selectedTask.taskPriority {
                            case .LOW:
                                Text(NSLocalizedString("Baixa", comment: ""))
                                    .foregroundColor(documentationViewModel.getPriorityFlagColor(priority: editTaskViewModel.selectedTask.taskPriority))
                            case .MEDIUM:
                                Text(NSLocalizedString("Moderada", comment: ""))
                                    .foregroundColor(documentationViewModel.getPriorityFlagColor(priority: editTaskViewModel.selectedTask.taskPriority))
                            case .HIGH:
                                Text(NSLocalizedString("Alta", comment: ""))
                                    .foregroundColor(documentationViewModel.getPriorityFlagColor(priority: editTaskViewModel.selectedTask.taskPriority))
                            case .VERY_HIGH:
                                Text(NSLocalizedString("Urgente", comment: ""))
                                    .foregroundColor(documentationViewModel.getPriorityFlagColor(priority: editTaskViewModel.selectedTask.taskPriority))
                            }
                        
                    }


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
//                PopUpButton(text: NSLocalizedString("Cancelar", comment: ""), onButtonTapped: {
//                    editTaskViewModel.isEditing.toggle()
//                })
                PopUpButton(text: NSLocalizedString("Salvar", comment: ""), onButtonTapped: saveTaskButton)
            }
        }
        
        func saveTaskButton() {
            let currDto = editTaskViewModel.dto
            TaskDataService.shared.saveTask(dto: editTaskViewModel.dto, userId: editTaskViewModel.userID, workspaceId: editTaskViewModel.workspaceID)
            editTaskViewModel.isEditing.toggle()
        }
}
