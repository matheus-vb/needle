//
//  DocumentationView.swift
//  NeedleApp
//
//  Created by matheusvb on 24/08/23.
//

import SwiftUI
import RichTextKit

struct DocumentationView: View {
    @State var isEditing: Bool = true
    
    var name: String
    var responsible: String
    var deadline: String
    var area: TaskType
    var priority: TaskPriority
    var members: [String:[User]]
    var documentationViewModel: DocumentationViewModel<DocumentationDataService>
    var backAction: () -> ()

    
    init(data: TaskModel, name: String, responsible: String, deadline: String, area: TaskType, priority: TaskPriority, members: [String:[User]], backAction: @escaping () -> ()) {
        self.name = name
        self.responsible = responsible
        self.deadline = deadline
        self.area = area
        self.priority = priority
        self.members = members
        self.documentationViewModel = DocumentationViewModel(data: data, userID: data.userId ?? "", workspaceID: data.workId, documentationID: data.documentId ?? "", documentationText: data.document?.text ?? "", documentationString: NSAttributedString(string: data.document?.textString ?? ""), members: members, isDeleting: false, docDS: DocumentationDataService.shared)
        self.backAction = backAction

    }
    
    var body: some View {
        VStack {
            backHeader.foregroundColor(Color.theme.grayPressed)
            informationHeader
            textContent
        }.padding(.bottom, 32)
        .background(.clear)
            .foregroundColor(.black)
    }
    
    var backHeader: some View {
        HStack {
            Button(action: { documentationViewModel.saveDoc()
                backAction() }, label: { Text("􀰪") })
                .buttonStyle(.borderless)
                .foregroundColor(Color.theme.grayButton)
            Text(name)
            Text(" // ")
            Text(NSLocalizedString("Documentação", comment: ""))
            Spacer()
        }
    }
    
    var informationHeader: some View {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                                Text("\(name)")
                                    .font(.system(size: 38, weight: .medium))
                                    .foregroundColor(.black)
                            Spacer()

                            Toggle(isOn: $isEditing, label: {
                                Text(isEditing ? NSLocalizedString("Modo de edição", comment: "") : NSLocalizedString("Modo de revisão", comment: ""))
                                    .font(.system(size: 12, weight: .semibold))
                            })
                                .toggleStyle(SwitchToggleStyle(tint: Color.theme.greenMain))
                        }.padding(.trailing, 20)
        
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
        HStack {
            editor
            Divider()
            toolbar
        }
//                .cornerRadius(6)
//                .background(Color.theme.grayHover)
    }
    
    var saveButton: some View {
        Button(action: {documentationViewModel.saveDoc()
            print("salvei")
        }, label: {Text(NSLocalizedString("Salvar", comment: ""))})
            .buttonStyle(CreateTemplateButton())
    }
    
    var editor: some View {
        RichTextEditor(text: Binding(
            get: {
                documentationViewModel.documentationString
            },
            set: {
                documentationViewModel.documentationString = $0
            }
        ), context: documentationViewModel.context) {
            $0.textContentInset = CGSize(width: 20, height: 40)
        }
        .cornerRadius(8)
        .focusedValue(\.richTextContext, documentationViewModel.context)
    }


    var toolbar: some View {
        VStack {
            if !isEditing {
                VStack {
                    Text(NSLocalizedString("Revisão do documento", comment: ""))
                    Text(NSLocalizedString("Aprove ou rejeite o documento. Opcionalmente, deixe feedbacks para o responsável no campo abaixo.", comment: ""))
                    
                }
                TextField("", text: Binding(get: {
                    documentationViewModel.docReview
                },
                                            set: {
                    documentationViewModel.docReview = $0
                }))
                
                VStack {
                    Button(action: {}, label: {Text(NSLocalizedString("Aprovar", comment: ""))})
                    Button(action: {}, label: {Text(NSLocalizedString("Rejeitar", comment: ""))})
                    HStack {
                        Text(NSLocalizedString("Tasks rejeitadas serão enviadas de volta à coluna Fazendo", comment: ""))
                        Image(systemName: "circle.fill")
                            .foregroundColor(Color.theme.blueKanban)
                    }
                }
            }
            else {
                RichTextFormatSidebar(context: documentationViewModel.context)
                    .layoutPriority(-1)
                    .foregroundColor(Color.theme.blackMain)
                saveButton
            }
        }
    }
    
    func getMembersList() -> [User]  {
        var list: [User] = []
        
        for u in members.values {
            for i in u {
                list.append(i)
                print(i.name)
            }
        }
        
        return list
    }
}
