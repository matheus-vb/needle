//
//  DocumentationView.swift
//  NeedleApp
//
//  Created by matheusvb on 24/08/23.
//

import SwiftUI
import RichTextKit

struct DocumentationView: View {
    var name: String
    var responsible: String
    var deadline: String
    var area: TaskType
    var priority: TaskPriority
    var members: [User]
    var documentationViewModel: DocumentationViewModel<DocumentationDataService>
    var backAction: () -> ()
    var documentationNS: NSAttributedString

    
    init(data: TaskModel, name: String, responsible: String, deadline: String, area: TaskType, priority: TaskPriority, members: [User], backAction: @escaping () -> ()) {
        self.name = name
        self.responsible = responsible
        self.deadline = deadline
        self.area = area
        self.priority = priority
        self.members = members
        self.documentationViewModel = DocumentationViewModel(data: data, userID: data.userId ?? "", workspaceID: data.workId, documentationID: data.documentId ?? "", documentationText: data.document?.text ?? "", documentationString: NSAttributedString(string: data.document?.textString ?? ""), members: members, isDeleting: false, docDS: DocumentationDataService.shared)
        self.backAction = backAction
        self.documentationNS = documentationViewModel.documentationString

    }
    
    var body: some View {
        VStack {
            backHeader.foregroundColor(Color.theme.grayPressed)
            informationHeader
            textContent
            saveButton
        }.background(.clear)
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
                        HStack {
                            editor
                            Divider()
                            toolbar
                        }.background(Color.theme.grayBackground)
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
            RichTextFormatSidebar(context: documentationViewModel.context)
                .layoutPriority(-1)
                .foregroundColor(Color.theme.blackMain)
        }
    }
}
