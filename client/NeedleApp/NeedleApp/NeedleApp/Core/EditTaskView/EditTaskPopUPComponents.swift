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
                .cornerRadius(6)
            Spacer()
                .frame(height: 10)
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
        HStack(spacing: 24){
            LabelComponent(imageName: "calendar", label: NSLocalizedString("Prazo", comment: ""))
            DatePicker(selection: $editTaskViewModel.deadLineSelection, in: editTaskViewModel.deadLineSelection..., displayedComponents: .date) {
                Text("Selecione uma data")
            }
            .labelsHidden()
            Spacer()
        }
        .font(.system(size: 16))
        .foregroundColor(Color.theme.grayPressed)
    }
    
    var responsible: some View {
        HStack(spacing: 24){
            LabelComponent(imageName: "person.fill", label: NSLocalizedString("Responsável", comment: ""))
            Picker(NSLocalizedString("Área", comment: ""),selection: $editTaskViewModel.dto.userId){
                ForEach(editTaskViewModel.members) {membro in
                    Text(membro.name)
                        .foregroundColor(Color.theme.blackMain)
                        .tag(membro.id as String?)
                }
            }
            .pickerStyle(.menu)
            .labelsHidden()
            Spacer()
        }
    }
        
    var type: some View {
        HStack(spacing: 24){
            LabelComponent(imageName: "shippingbox", label:NSLocalizedString("Área", comment: ""))
            Picker("Área",selection: $editTaskViewModel.categorySelection){
               ForEach(TaskType.allCases, id: \.self) { type in
                   Text(type.displayName)
                       .foregroundColor(Color.theme.blackMain)
               }
           }
           .pickerStyle(.menu)
           .labelsHidden()
            Spacer()
        }
    }
    
    var priority: some View {
        HStack(spacing: 24){
            LabelComponent(imageName: "flag.fill", label: NSLocalizedString("Prioridade", comment: ""))
            Picker("Prioridade",selection: $editTaskViewModel.prioritySelection){
                ForEach(TaskPriority.allCases, id: \.self) { priority in
                    Text(priority.displayName)
                        .foregroundColor(Color.theme.blackMain)
                }
            }
            .pickerStyle(.menu)
            .labelsHidden()
            Spacer()
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
                    .frame(minHeight: geometry.size.height*0.042, maxHeight: geometry.size.height*0.065)
                    .font(.custom("SF Pro", size: 16))
                    .lineSpacing(1)
                    .multilineTextAlignment(.leading)
                    .padding(2)
                    .colorMultiply(Color.theme.grayBackground)
        }
    }
    
    var attributesStack: some View {
        VStack(alignment: .leading){
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
                .buttonStyle(PrimarySheetActionButton())
            Button(action: {saveTaskButton()}, label: {
                Text(NSLocalizedString("Salvar", comment: ""))
                     })
                .buttonStyle(SecondarySheetActionButton())
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
        editTaskViewModel.seeDocumentation.toggle()
    }
}
