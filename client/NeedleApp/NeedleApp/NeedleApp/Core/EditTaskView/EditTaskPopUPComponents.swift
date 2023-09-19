//
//  EditTaskPopUPComponents.swift
//  NeedleApp
//
//  Created by jpcm2 on 08/08/23.
//

import Foundation
import SwiftUI

extension EditTaskPopUP{
    
    var contentStack: some View{
        VStack(alignment: .leading, spacing: 20){
            taskTitle.padding(.top, 8)
            attributesStack
            description
            documentationArea.padding(.bottom, 40)
            HStack{
                archiveDeleteStack
                Spacer()
                saveTask
            }
        }
    }
    
    var taskTitle: some View {
        TextEditor(text: $editTaskViewModel.taskTitle)
            .textFieldStyle(.plain)
            .font(.system(size: 40, weight: .medium))
            .foregroundColor(.black)
            .frame(maxHeight: 60)
            .scrollIndicators(.hidden)
    }
    var deadLine: some View{
        HStack(spacing: 12){
            LabelComponent(imageName: "calendar", label: NSLocalizedString("Prazo", comment: ""))
                .font(.system(size: 14))

            DatePicker(selection: $editTaskViewModel.deadLineSelection, in: Date()..., displayedComponents: .date) {
                Text(NSLocalizedString("Selecione uma data", comment: ""))
            }
            .labelsHidden()
        }
        .font(.system(size: 14))
        .foregroundColor(Color.theme.grayPressed)
    }
    
    var responsible: some View {
        HStack(spacing: 12){
            LabelComponent(imageName: "person.fill", label: NSLocalizedString("Responsável", comment: ""))
                .font(.system(size: 14))

            Picker(NSLocalizedString("Área", comment: ""),selection: $editTaskViewModel.dto.userId){
                    ForEach(editTaskViewModel.members) {membro in
                        Text(membro.name)
                            .foregroundColor(Color.theme.blackMain)
                            .tag(editTaskViewModel.dto.userId == nil ? editTaskViewModel.members[0].id :
                                membro.id as String?)
                    }
            }
            .font(.system(size: 14))
            .pickerStyle(.menu)
            .labelsHidden()
        }
    }
        
    var type: some View {
        HStack(spacing: 12){
            LabelComponent(imageName: "shippingbox", label:NSLocalizedString("Área", comment: ""))
                .font(.system(size: 14))

            Picker("Área",selection: $editTaskViewModel.categorySelection){
               ForEach(TaskType.allCases, id: \.self) { type in
                   Text(type.displayName)
                       .foregroundColor(Color.theme.blackMain).tag("")
               }
           }
            .font(.system(size: 14))
           .pickerStyle(.menu)
           .labelsHidden()
        }
    }
    
    var priority: some View {
        HStack(spacing: 12){
            LabelComponent(imageName: "flag.fill", label: NSLocalizedString("Prioridade", comment: ""))

            Picker("Prioridade",selection: $editTaskViewModel.prioritySelection){
                ForEach(TaskPriority.allCases, id: \.self) { priority in
                    Text(priority.displayName)
                        .foregroundColor(Color.theme.blackMain)
                }
            }
            .font(.system(size: 14))
            .pickerStyle(.menu)
            .labelsHidden()
        }
    }
    
    var placeholder: String {
        return NSLocalizedString("Descrição curta da task", comment: "") 
    }
    
    var description: some View{
        VStack(alignment: .leading, spacing: 12) {
            Text(NSLocalizedString("Descrição", comment: ""))
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(Color.theme.grayPressed)
            
                TextEditor(text: Binding(projectedValue: $editTaskViewModel.taskDescription))
                    .font(.custom("SF Pro", size: 16))
                    .lineSpacing(1)
                    .cornerRadius(8)
                    .multilineTextAlignment(.leading)
                    .colorMultiply(Color.theme.grayBackground)
        
        }.frame(minHeight: 100)
    }
    
    var attributesStack: some View {
        VStack(alignment: .leading, spacing: 8){
            deadLine
            responsible
            type
            priority
        }
    }
    
    var archiveDeleteStack: some View{
        HStack{
            HStack(spacing: 24){
                Button(action: {
                    editTaskViewModel.isDeleting.toggle()
                }, label: {
                    Image(systemName: "trash")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.theme.redMain)
                })
                Button(action: {
                    if(editTaskViewModel.selectedTask.status == TaskStatus.NOT_VISIBLE){
                        editTaskViewModel.unarchiveTask()
                        editTaskViewModel.isEditing.toggle()
                    }else{
                        editTaskViewModel.archiveTask()
                        editTaskViewModel.isEditing.toggle()
                    }
                }, label: {
                    Image(systemName: (editTaskViewModel.selectedTask.status == TaskStatus.NOT_VISIBLE ? "arrow.up.bin" : "archivebox"))
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.theme.blackMain)
                })
            }        }
        .buttonStyle(.plain)
    }
    
    var seeDocumentationButton: some View {
        DashedButton(text: editTaskViewModel.selectedTask.document?.text == template.devTemplate ? NSLocalizedString("Criar documentação", comment: "") : NSLocalizedString("Editar documentação", comment: ""), onButtonTapped: openDocumentation)
    }
    
    var documentationArea: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(NSLocalizedString("Documentação", comment: ""))
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(Color.theme.grayPressed)
            seeDocumentationButton
            Text(NSLocalizedString("Ninguém documentou nada ainda. Seja o primeiro!", comment: ""))
                .opacity(editTaskViewModel.selectedTask.document?.text == template.devTemplate ? 1 : 0)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(Color.theme.grayHover)

        }
    }
    
    var saveTask: some View{
        HStack{
            Button(action: {cancelButton()}, label: {
                Text(NSLocalizedString("Cancelar", comment: ""))
                     })
                .buttonStyle(SecondarySheetActionButton())
            Button(action: {saveTaskButton()}, label: {
                Text(NSLocalizedString("Salvar", comment: ""))
                     })
                .buttonStyle(PrimarySheetActionButton())
        }
    }
    
    func cancelButton(){
        editTaskViewModel.isEditing.toggle()
    }
    
    
    func saveTaskButton(){
        editTaskViewModel.saveTask()
        editTaskViewModel.isEditing.toggle()
    }
    
    func openDocumentation(){
        seeDocumentation = true
    }
}
