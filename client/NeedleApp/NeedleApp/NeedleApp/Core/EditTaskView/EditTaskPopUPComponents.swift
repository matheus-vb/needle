//
//  EditTaskPopUPComponents.swift
//  NeedleApp
//
//  Created by jpcm2 on 08/08/23.
//

import Foundation
import SwiftUI

extension EditTaskPopUP{
    var taskTitle: some View {
        TextEditor(text: $editTaskViewModel.taskTitle)
            .textFieldStyle(.plain)
            .font(.system(size: 40, weight: .medium))
            .foregroundColor(.black)
            .frame(maxHeight: 60)
    }
    var deadLine: some View{
        HStack(spacing: 24){
            LabelComponent(imageName: "calendar", label: "Prazo")
            DatePicker(selection: $editTaskViewModel.deadLineSelection, in: editTaskViewModel.deadLineSelection..., displayedComponents: .date) {
                Text("Select a date")
            }
            .labelsHidden()
            Spacer()
        }
        .font(.system(size: 16))
        .foregroundColor(Color.theme.grayPressed)
    }
    
    var responsible: some View {
        HStack(spacing: 24){
            LabelComponent(imageName: "person.fill", label: "Responsável")
            Picker("Área",selection: $editTaskViewModel.dto.userId){
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
            LabelComponent(imageName: "shippingbox", label:"Área")
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
            LabelComponent(imageName: "flag.fill", label: "Prioridade")
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
    
    var description: some View{
        VStack(alignment: .leading ,spacing: 12){
            Text("Descrição")
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(Color.theme.blackMain)
            TextEditor(text: $editTaskViewModel.taskDescription)
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(Color.theme.grayPressed)
                .frame(minHeight: 20)
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
    
    var topSection: some View{
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
                        editTaskViewModel.unarchiveTask(task: editTaskViewModel.selectedTask)
                        editTaskViewModel.isEditing.toggle()
                    }else{
                        editTaskViewModel.archiveTask(task: editTaskViewModel.selectedTask)
                        editTaskViewModel.isEditing.toggle()
                    }
                }, label: {
                    Image(systemName: (editTaskViewModel.selectedTask.status == TaskStatus.NOT_VISIBLE ? "arrow.up.bin" : "archivebox"))
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.theme.blackMain)
                })
            }
            Spacer()
            Button(action: {
                editTaskViewModel.isEditing.toggle()
            }, label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
            })
        }
        .buttonStyle(.plain)
    }
    
    var contentStack: some View{
        VStack(spacing: 30){
            taskTitle
            attributesStack
            description
            Spacer()
            DashedButton(text: "Visualizar documentação", onButtonTapped: openDocumentation)
            Spacer()
            HStack{
                Spacer()
                saveTask
            }
        }
        .frame(minHeight: geometry.size.height - 128)
    }
    var saveTask: some View{
        HStack{
            PopUpButton(text: "Cancelar", onButtonTapped: cancelButton)
            PopUpButton(text: "Salvar", onButtonTapped: saveTaskButton)
        }
    }
    
    func cancelButton(){
        editTaskViewModel.isEditing.toggle()
    }
    
    
    func saveTaskButton(){
        let currDto = editTaskViewModel.dto        
        TaskDataService.shared.saveTask(dto: editTaskViewModel.dto, userId: editTaskViewModel.userID, workspaceId: editTaskViewModel.workspaceID)
        editTaskViewModel.isEditing.toggle()
    }
    
    func openDocumentation(){
        editTaskViewModel.seeDocumentation.toggle()
    }
}
