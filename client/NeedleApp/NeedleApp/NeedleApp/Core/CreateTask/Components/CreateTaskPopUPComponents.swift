//
//  CreateTaskPopUPComponents.swift
//  NeedleApp
//
//  Created by jpcm2 on 04/08/23.
//

import SwiftUI


extension CreateTaskPopUp{
    var taskTitle: some View {
        TitleEditableText(text: $createTaskViewModel.taskTitle)
    }
    var deadLine: some View{
        HStack(spacing: 24){
            LabelComponent(imageName: "calendar", label: "Prazo")
            DatePicker(selection: $createTaskViewModel.deadLineSelection, in: Date.now..., displayedComponents: .date) {
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
            Picker("Área",selection: $createTaskViewModel.selectedMember){
                ForEach(createTaskViewModel.members, id: \.self) {membro in
                    Text(membro.name)
                        .foregroundColor(Color.theme.blackMain)
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
            Picker("Área",selection: $createTaskViewModel.categorySelection){
               ForEach(TaskType.allCases, id: \.self) { type in
                   Text(type.rawValue)
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
            Picker("Prioridade",selection: $createTaskViewModel.prioritySelection){
                ForEach(TaskPriority.allCases, id: \.self) { priority in
                    Text(priority.rawValue)
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
            TextEditor(text: $createTaskViewModel.taskDescription)
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(Color.theme.grayPressed)
        }
        .frame(minHeight: geometry.size.height - 420)
    }
    
    var attributesStack: some View {
        VStack(alignment: .leading){
            deadLine
            responsible
            type
            priority
        }
    }
    
    var contentStack: some View{
        VStack(spacing: 30){
            taskTitle
            attributesStack
            ScrollView{
                description
                Spacer()
                HStack{
                    Spacer()
                    createTask
                }
            }
        }
        .frame(minHeight: geometry.size.height - 128)
    }
    
    var topSection: some View{
        HStack{
            Spacer()
            Button(action: {
                projectViewModel.showPopUp.toggle()
            }, label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
            })
        }
        .buttonStyle(.plain)
    }
    
    var createTask: some View {
        HStack{
            PopUpButton(text: "Cancelar", onButtonTapped: cancelButton)
            PopUpButton(text: "Criar", onButtonTapped: createTaskButton)
        }
    }
    
    func cancelButton(){
        projectViewModel.showPopUp.toggle()
    }
    
    func createTaskButton(){
        @AppStorage("userID") var userID: String = "Default User"
        let dto = CreateTaskDTO(userId: nil, accessCode: projectViewModel.selectedProject.accessCode, title: createTaskViewModel.taskTitle, description: createTaskViewModel.taskDescription, stats: projectViewModel.selectedColumnStatus.rawValue, type: createTaskViewModel.categorySelection.rawValue, endDate: "\(createTaskViewModel.deadLineSelection)", priority: createTaskViewModel.prioritySelection.rawValue)
        projectViewModel.createTask(dto: dto)
        projectViewModel.showPopUp.toggle()
    }
}
