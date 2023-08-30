//
//  CreateTaskPopUPComponents.swift
//  NeedleApp
//
//  Created by jpcm2 on 04/08/23.
//

import SwiftUI


extension CreateTaskPopUp{
    var taskTitle: some View {
        TextEditor(text: $createTaskViewModel.taskTitle)
            .textFieldStyle(.plain)
            .font(.system(size: 40, weight: .medium))
            .foregroundColor(.black)
            .frame(maxHeight: 60)
    }
    var deadLine: some View{
        HStack(spacing: 24){
            LabelComponent(imageName: "calendar", label: NSLocalizedString("Prazo", comment: ""))
            DatePicker(selection: $createTaskViewModel.deadLineSelection, in: Date.now..., displayedComponents: .date) {
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
            Picker("Área",selection: $createTaskViewModel.selectedMemberId){
                ForEach(createTaskViewModel.members) { membro in
                    Text(membro.name)
                        .foregroundColor(Color.theme.blackMain)
                        .tag(membro.id)
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
            Picker(NSLocalizedString("Área", comment: ""),selection: $createTaskViewModel.categorySelection){
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
            Picker(NSLocalizedString("Prioridade", comment: ""),selection: $createTaskViewModel.prioritySelection){
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
            ZStack {
                if createTaskViewModel.taskDescription == "" {
                    TextEditor(text:$createTaskViewModel.taskDescriptionPlaceHolder)
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(Color.theme.grayPressed)
                }
                TextEditor(text: $createTaskViewModel.taskDescription)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(Color.theme.grayPressed)
            }
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
                createTaskViewModel.showPopUp.toggle()
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
        createTaskViewModel.showPopUp.toggle()
    }
    
    func createTaskButton(){
        createTaskViewModel.createTask()
        createTaskViewModel.showPopUp.toggle()
    }
}
