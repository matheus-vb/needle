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
            .frame(maxWidth: geometry.size.width*0.26)
            .labelsHidden()
            Spacer()
        }
        .font(.system(size: 16))
        .foregroundColor(Color.theme.grayPressed)
    }
    
    var responsible: some View {
        HStack(spacing: 24){
            LabelComponent(imageName: "person.fill", label: NSLocalizedString("Responsável", comment: ""))
            Picker(NSLocalizedString("Área", comment: ""),selection: $createTaskViewModel.selectedMemberId){
                ForEach(createTaskViewModel.members) { membro in
                    Text(membro.name)
                        .foregroundColor(Color.theme.blackMain)
                        .tag(Optional(membro.id))
                }
            }
            .frame(maxWidth: geometry.size.width*0.26)
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
            .frame(maxWidth: geometry.size.width*0.26)
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
            .frame(maxWidth: geometry.size.width*0.26)
            .pickerStyle(.menu)
            .labelsHidden()
            Spacer()
        }
    }
    
    var description: some View{
        VStack(alignment: .leading, spacing: 12) {
            Text(NSLocalizedString("Descrição", comment: ""))
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(Color.theme.grayPressed)
            
                TextEditor(text: Binding(projectedValue: $createTaskViewModel.taskDescription))
                .font(.custom("SF Pro", size: 16))
                .lineSpacing(1)
                .cornerRadius(12)
                .multilineTextAlignment(.leading)
                .colorMultiply(Color.theme.grayBackground)
        }.frame(minHeight: 100)
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
                description
            HStack{
                Spacer()
                createTask
            }
        }
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
