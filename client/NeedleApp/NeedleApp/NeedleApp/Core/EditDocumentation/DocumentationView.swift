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
    
    var geometry: GeometryProxy
    
    @Binding var documentationNS: NSAttributedString
    
    @State var backButtonHovered: Bool = false
    
    init(workspaceId: String, documentId: String, documentationNS: Binding<NSAttributedString>, editTaskViewModel: EditTaskViewModel<TaskDataService>, geometry: GeometryProxy) {
        self.documentationViewModel = DocumentationViewModel(workspaceId: workspaceId, documentId: documentId, docDS: DocumentationDataService.shared)
        self.editTaskViewModel = editTaskViewModel
        self._documentationNS = documentationNS
        self.geometry = geometry
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
                Spacer()
            saveTask
        }
            
        }
        
        var taskDataHeader: some View {
            VStack(alignment: .center, spacing: 32) {
                HStack {
                    Button(action: {editTaskViewModel.seeDocumentation.toggle()}, label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10)
                            .foregroundColor(backButtonHovered ? Color.theme.blackMain : Color.theme.grayHover)
                    }).onHover(perform: { hover in
                        backButtonHovered.toggle()
                    })
                    .scaleEffect(backButtonHovered ? 1.1 : 0.98)
                    .animation(.spring(), value: backButtonHovered)
                    .buttonStyle(.borderless)
                    Spacer()
                        Text("\(editTaskViewModel.taskTitle)")
                            .font(.system(size: 38, weight: .medium))
                            .foregroundColor(.black)
                    Spacer()
                }
                
                HStack(spacing: 20) {
                    HStack(spacing: 8) {
                        LabelComponent(imageName: "calendar", label: geometry.size.width <= 1360 ? "": NSLocalizedString("Prazo", comment: ""))
                            .font(.system(size: 14, weight: .regular))

                        Text("\(HandleDate.formatDateWithoutTime(dateInput: editTaskViewModel.selectedTask.endDate))")
                            .font(.system(size: 14, weight: .regular))

                    }
                    HStack(spacing: 12) {
                        LabelComponent(imageName: "shippingbox", label: geometry.size.width <= 1360 ? "": NSLocalizedString("Área", comment: ""))
                            .font(.system(size: 14, weight: .regular))

                        KanbanTagView(taskType: editTaskViewModel.selectedTask.type)
                    }
                    HStack(spacing: 12) {
                        LabelComponent(imageName: "person.fill", label: geometry.size.width <= 1360 ? "": NSLocalizedString("Responsável", comment: ""))
                            .font(.system(size: 12, weight: .regular))
                        
                        Text(editTaskViewModel.selectedTask.user?.name ?? NSLocalizedString("Sem responsável.", comment: ""))
                            .font(.system(size: 14, weight: .regular))

                    }
                    HStack(spacing: 12) {
                        LabelComponent(imageName: "flag.fill", label: geometry.size.width <= 1360 ? "": NSLocalizedString("Prioridade", comment: ""))
                            .font(.system(size: 14, weight: .regular))

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
            .cornerRadius(8)
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
                Button(action: {
                    editTaskViewModel.isEditing.toggle()
                    print("fechei pelo cancelar")
                }, label: {
                   Text(NSLocalizedString("Cancelar", comment: ""))
                }).buttonStyle(SecondarySheetActionButton())
                Button(action: {
                    saveTaskButton()
                }, label: {
                   Text(NSLocalizedString("Salvar", comment: ""))
                }).buttonStyle(PrimarySheetActionButton())
            }
        }
        
        func saveTaskButton() {
            let currDto = editTaskViewModel.dto
            TaskDataService.shared.saveTask(dto: editTaskViewModel.dto, userId: editTaskViewModel.userID, workspaceId: editTaskViewModel.workspaceID)
            editTaskViewModel.isEditing.toggle()
        }
}
