//
//  DocumentationView.swift
//  NeedleApp
//
//  Created by matheusvb on 24/08/23.
//

import SwiftUI
import RichTextKit

struct DocumentationView: View {
    var name = "Titulo da Task"
    var responsible = "Fulano de Tal"
    var deadline = "22/04/2022"
    var area: TaskType = .DESIGN
    var priority: TaskPriority = .LOW

    var body: some View {
        VStack {
            backHeader.foregroundColor(Color.theme.grayPressed)
            informationHeader
            textContent
            saveButton
        }.background(Color.theme.grayBackground)
            .foregroundColor(.black)
    }
    
    var backHeader: some View {
        HStack {
            Text("􀰪")
            Text(name)
            Text(" ")
            Text(NSLocalizedString("Documentação", comment: ""))
            Spacer()
        }
    }
    
    var informationHeader: some View {
                    VStack(alignment: .center, spacing: 12) {
                        HStack {
                                Text("\(name)")
                                    .font(.system(size: 38, weight: .medium))
                                    .foregroundColor(.black)
                            Spacer()
                        }
        
                        HStack(spacing: 32) {
                            HStack(spacing: 12) {
                                LabelComponent(imageName: "calendar", label: NSLocalizedString("Prazo", comment: ""))
                                    .font(.system(size: 14, weight: .regular))
        
                                Text("\(HandleDate.formatDateWithoutTime(dateInput: deadline))")
                                    .font(.system(size: 14, weight: .regular))
        
                            }
                            HStack(spacing: 12) {
                                LabelComponent(imageName: "shippingbox", label: NSLocalizedString("Área", comment: ""))
                                    .font(.system(size: 14, weight: .regular))
        
                                KanbanTagView(taskType: area)
                            }
                            HStack(spacing: 12) {
                                LabelComponent(imageName: "person.fill", label: NSLocalizedString("Responsável", comment: ""))
                                    .font(.system(size: 12, weight: .regular))
        
                                Text(responsible)
                                    .font(.system(size: 14, weight: .regular))
        
                            }
                            HStack(spacing: 12) {
                                LabelComponent(imageName: "flag.fill", label: NSLocalizedString("Prioridade", comment: ""))
                                    .font(.system(size: 14, weight: .regular))
        
                                    switch priority {
                                    case .LOW:
                                        Text(NSLocalizedString("Baixa", comment: ""))
                                            .foregroundColor(Color.theme.greenKanban)
                                    case .MEDIUM:
                                        Text(NSLocalizedString("Moderada", comment: ""))
                                            .foregroundColor(Color.theme.orangeMain)
                                    case .HIGH:
                                        Text(NSLocalizedString("Alta", comment: ""))
                                            .foregroundColor(Color.theme.redMain)
                                    case .VERY_HIGH:
                                        Text(NSLocalizedString("Urgente", comment: ""))
                                            .foregroundColor(Color.theme.grayPressed)
                                    }
        
                            }
        
        
                        }
        
                    }
    }
    
    var textContent: some View {
        VStack {
            
        }
    }
    
    var saveButton: some View {
        Button(action: {}, label: {})
            .buttonStyle(CreateTemplateButton())
    }
}

struct DocumentationView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentationView()
    }
}

//struct DocumentationView: View {
//    @StateObject var editTaskViewModel: EditTaskViewModel<TaskDataService>
//    @Environment(\.dismiss) var dismiss
//
//    var geometry: GeometryProxy
//
//    var action: () -> ()
//
//    @Binding var documentationNS: NSAttributedString
//
//    @State var backButtonHovered: Bool = false
//
//    init(workspaceId: String, documentId: String, documentationNS: Binding<NSAttributedString>, editTaskViewModel: EditTaskViewModel<TaskDataService>,  action: @escaping () -> (), geometry: GeometryProxy) {
//        self.action = action
//        self._editTaskViewModel = StateObject(wrappedValue: editTaskViewModel)
//        self._documentationNS = documentationNS
//        self.geometry = geometry
//    }
//
//    var body: some View {
//        VStack(alignment: .center) {
//                taskDataHeader.padding(.top, 20)
//                Spacer()
//                HStack {
//                    editor
//                    leftBorder
//                    toolbar
//                }.background(Color.theme.grayBackground)
//                Spacer()
//            saveTask
//        }
//
//        }
//
//        var taskDataHeader: some View {
//            VStack(alignment: .center, spacing: 32) {
//                HStack {
//                    Button(action: {
//                        action()
//
//                    }, label: {
//                        Image(systemName: "chevron.backward")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 10)
//                            .foregroundColor(backButtonHovered ? Color.theme.blackMain : Color.theme.grayHover)
//                    }).onHover(perform: { hover in
//                        backButtonHovered.toggle()
//                    })
//                    .scaleEffect(backButtonHovered ? 1.1 : 0.98)
//                    .animation(.spring(), value: backButtonHovered)
//                    .buttonStyle(.borderless)
//                    Spacer()
//                        Text("\(editTaskViewModel.taskTitle)")
//                            .font(.system(size: 38, weight: .medium))
//                            .foregroundColor(.black)
//                    Spacer()
//                }
//
//                HStack(spacing: 20) {
//                    HStack(spacing: 8) {
//                        LabelComponent(imageName: "calendar", label: geometry.size.width <= 1360 ? "": NSLocalizedString("Prazo", comment: ""))
//                            .font(.system(size: 14, weight: .regular))
//
//                        Text("\(HandleDate.formatDateWithoutTime(dateInput: editTaskViewModel.selectedTask.endDate))")
//                            .font(.system(size: 14, weight: .regular))
//
//                    }
//                    HStack(spacing: 12) {
//                        LabelComponent(imageName: "shippingbox", label: geometry.size.width <= 1360 ? "": NSLocalizedString("Área", comment: ""))
//                            .font(.system(size: 14, weight: .regular))
//
//                        KanbanTagView(taskType: editTaskViewModel.selectedTask.type)
//                    }
//                    HStack(spacing: 12) {
//                        LabelComponent(imageName: "person.fill", label: geometry.size.width <= 1360 ? "": NSLocalizedString("Responsável", comment: ""))
//                            .font(.system(size: 12, weight: .regular))
//
//                        Text(editTaskViewModel.selectedTask.user?.name ?? NSLocalizedString("Sem responsável.", comment: ""))
//                            .font(.system(size: 14, weight: .regular))
//
//                    }
//                    HStack(spacing: 12) {
//                        LabelComponent(imageName: "flag.fill", label: geometry.size.width <= 1360 ? "": NSLocalizedString("Prioridade", comment: ""))
//                            .font(.system(size: 14, weight: .regular))
//
//                            switch editTaskViewModel.selectedTask.taskPriority {
//                            case .LOW:
//                                Text(NSLocalizedString("Baixa", comment: ""))
//                                    .foregroundColor(editTaskViewModel.getPriorityFlagColor(priority: editTaskViewModel.selectedTask.taskPriority))
//                            case .MEDIUM:
//                                Text(NSLocalizedString("Moderada", comment: ""))
//                                    .foregroundColor(editTaskViewModel.getPriorityFlagColor(priority: editTaskViewModel.selectedTask.taskPriority))
//                            case .HIGH:
//                                Text(NSLocalizedString("Alta", comment: ""))
//                                    .foregroundColor(editTaskViewModel.getPriorityFlagColor(priority: editTaskViewModel.selectedTask.taskPriority))
//                            case .VERY_HIGH:
//                                Text(NSLocalizedString("Urgente", comment: ""))
//                                    .foregroundColor(editTaskViewModel.getPriorityFlagColor(priority: editTaskViewModel.selectedTask.taskPriority))
//                            }
//
//                    }
//
//
//                }
//
//            }
//        }
//
//        var editor: some View {
//            RichTextEditor(text: $documentationNS, context: editTaskViewModel.context) {
//                $0.textContentInset = CGSize(width: 20, height: 40)
//            }
//            .cornerRadius(8)
//            .focusedValue(\.richTextContext, editTaskViewModel.context)
//        }
//
//        var toolbar: some View {
//            VStack {
//                RichTextFormatSidebar(context: editTaskViewModel.context)
//                    .layoutPriority(-1)
//                    .foregroundColor(Color.theme.blackMain)
//            }
//        }
//
//        var leftBorder: some View {
//            HStack {
//                Rectangle()
//                    .frame(width: 2)
//                    .foregroundColor(Color.theme.blackMain)
//            }
//        }
//
//        var saveTask: some View{
//            HStack{
//                Button(action: {
//                    editTaskViewModel.isEditing.toggle()
//                    print("fechei pelo cancelar")
//                }, label: {
//                   Text(NSLocalizedString("Cancelar", comment: ""))
//                }).buttonStyle(SecondarySheetActionButton())
//                Button(action: {
//                    saveTaskButton()
//                }, label: {
//                   Text(NSLocalizedString("Salvar", comment: ""))
//                }).buttonStyle(PrimarySheetActionButton())
//            }
//        }
//
//        func saveTaskButton() {
//            let currDto = editTaskViewModel.dto
//            TaskDataService.shared.saveTask(dto: editTaskViewModel.dto, userId: editTaskViewModel.userID, workspaceId: editTaskViewModel.workspaceID)
//            editTaskViewModel.isEditing.toggle()
//        }
//}
