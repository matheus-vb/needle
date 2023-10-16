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
        GeometryReader { geometry in
            VStack {
                backHeader.foregroundColor(Color.theme.grayPressed)
                informationHeader
                HStack {
                    textContent.background(Color.theme.grayBackground)
                    toolbar
                        .frame(width: geometry.size.width*0.18)
                        .background(isEditing ? Color.theme.grayBackground : .white)
                }
            }.padding(.bottom, 32)
                .background(.clear)
                .foregroundColor(.black)
        }
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
                revisionBlock
            }
            else {
                RichTextFormatSidebar(context: documentationViewModel.context)
                    .layoutPriority(-1)
                    .foregroundColor(Color.theme.blackMain)
                saveButton
                    .padding(.bottom, 12)
            }
        }
    }
    
    var revisionBlock: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    Text(NSLocalizedString("Revisão do documento", comment: ""))
                        .font(.system(size: 16, weight: .semibold))
                    Text(NSLocalizedString("Aprove ou rejeite o documento. Opcionalmente, deixe feedbacks para o responsável no campo abaixo.", comment: ""))
                        .font(.system(size: 12, weight: .regular))
                    
                }
                TextEditor(text: Binding(get: {
                    documentationViewModel.docReview
                },
                                            set: {
                    documentationViewModel.docReview = $0
                }))
                .cornerRadius(6)
                .background(Color.theme.grayBackground)
                .frame(width: geometry.size.width, height: geometry.size.height*0.63)
                
                VStack(alignment: .leading, spacing: 16) {
                    VStack(spacing: 12) {
                        Button(action: {}, label: {Text(NSLocalizedString("Aprovar", comment: ""))})
                        Button(action: {}, label: {Text(NSLocalizedString("Rejeitar", comment: ""))})
                    }
                    HStack(spacing: 0) {
                        Text(NSLocalizedString("Tasks rejeitadas serão enviadas de volta à coluna", comment: ""))
                            .foregroundColor(.black) + Text(" ") + Text(NSLocalizedString("Fazendo", comment: "")).foregroundColor(Color.theme.blueKanban)
                            .font(.system(size: 10, weight: .regular))
                        Image(systemName: "circle.fill")
                            .foregroundColor(Color.theme.blueKanban)
                            .frame(width: 10, height: 10)
                    }
                }
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
