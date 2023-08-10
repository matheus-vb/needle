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
        TitleEditableText(text: $editTaskViewModel.taskTitle)
    }
    var deadLine: some View{
        HStack(spacing: 24){
            LabelComponent(imageName: "calendar", label: "Prazo")
            DatePicker(selection: $editTaskViewModel.deadLineSelection, in: editTaskViewModel.deadLineSelection..., displayedComponents: .date) {
                Text("Select a date")
            }
            .colorInvert()
            .colorMultiply(Color.theme.blackMain)
            .labelsHidden()
            .background(Color.clear)
            .border(Color.clear)
            Spacer()
        }
        .font(.system(size: 16))
        .foregroundColor(Color.theme.grayPressed)
    }
    
    var responsible: some View {
        HStack(spacing: 24){
            LabelComponent(imageName: "person.fill", label: "Responsável")
            Picker("Área",selection: $editTaskViewModel.selectedMember){
                ForEach(editTaskViewModel.members, id: \.self) {membro in
                    Text(membro.name)
                        .foregroundColor(Color.theme.blackMain)
                        .tag(membro as User?)
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
                .frame(minHeight: 120)
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
                    if(projectViewModel.selectedTask?.status == TaskStatus.NOT_VISIBLE.rawValue){
                        editTaskViewModel.unarchiveTask(task: projectViewModel.selectedTask!)
                    }else{
                        editTaskViewModel.archiveTask(task: projectViewModel.selectedTask!)
                    }
                }, label: {
                    Image(systemName: (projectViewModel.selectedTask?.status == TaskStatus.NOT_VISIBLE.rawValue ? "arrow.up.bin" : "archivebox"))
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.theme.orangeKanban)
                })
            }
            Spacer()
            Button(action: {
                projectViewModel.showEditTaskPopUP.toggle()
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
            ScrollView{
                description
                textEditor
                HStack{
                    Spacer()
                    saveTask
                }
            }
        }
        .frame(minHeight: geometry.size.height - 128)
    }
    
    var textEditor: some View {
        EditDocumentationView(documentation: $editTaskViewModel.documentationString)
            .environmentObject(editTaskViewModel)
            .foregroundColor(.white)
            .background(.black)
    }
    var saveTask: some View{
        HStack{
            PopUpButton(text: "Cancelar", onButtonTapped: cancelButton)
            PopUpButton(text: "Salvar", onButtonTapped: saveTaskButton)
        }
    }
    
    func cancelButton(){
        projectViewModel.showEditTaskPopUP.toggle()
    }
    
    func saveTaskButton(){
        do {
            let dado = try editTaskViewModel.documentationString.richTextData(for: .rtf)
            let encodedData = dado.base64EncodedString(options: .lineLength64Characters)
            let data = SaveTaskDTO(userId: editTaskViewModel.selectedMember?.id, taskId: projectViewModel.selectedTask!.id ?? "1", documentId: projectViewModel.selectedTask!.documentId ?? "1", title: editTaskViewModel.taskTitle, description: editTaskViewModel.taskDescription, status: editTaskViewModel.statusSelection.rawValue, type: editTaskViewModel.categorySelection.rawValue, endDate: "\(editTaskViewModel.deadLineSelection)", priority: editTaskViewModel.prioritySelection.rawValue, text: encodedData, textString: editTaskViewModel.documentationString.string)
            TaskDataService.shared.saveTask(dto: data, userId: editTaskViewModel.userID, workspaceId: editTaskViewModel.workspaceID)
            projectViewModel.showEditTaskPopUP.toggle()
        }catch{
            print(error)
        }
    }
}
