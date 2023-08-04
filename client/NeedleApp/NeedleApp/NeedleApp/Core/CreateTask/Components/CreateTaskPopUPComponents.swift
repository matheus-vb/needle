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
            .colorMultiply(Color.theme.mainBlack)
            .labelsHidden()
            .background(Color.clear)
            .border(Color.clear)
        }
        .font(.system(size: 16))
        .foregroundColor(Color.theme.mainGray)
    }
    
    var responsible: some View {
        HStack(spacing: 24){
            LabelComponent(imageName: "person.fill", label: "Responsável")
            Picker("Área",selection: $createTaskViewModel.selectedMember){
                ForEach(createTaskViewModel.members, id: \.self) {membro in
                    Text(membro.name)
                }
            }
            .pickerStyle(.menu)
            .labelsHidden()
        }
    }
        
    var type: some View {
        HStack(spacing: 24){
            LabelComponent(imageName: "shippingbox", label:"Área")
            Picker("Área",selection: $createTaskViewModel.categorySelection){
               ForEach(TaskType.allCases, id: \.self) { type in
                   Text(type.rawValue)
               }
           }
           .pickerStyle(.menu)
           .labelsHidden()
        }
    }
    
    var priority: some View {
        HStack(spacing: 24){
            LabelComponent(imageName: "flag.fill", label: "Prioridade")
            Picker("Prioridade",selection: $createTaskViewModel.prioritySelection){
                ForEach(TaskPriority.allCases, id: \.self) { priority in
                    Text(priority.rawValue)
                }
            }
            .pickerStyle(.menu)
            .labelsHidden()
        }
    }
    
    var attributesStack: some View {
        VStack(alignment: .leading){
            deadLine
            responsible
            type
            priority
        }
        .padding([.trailing], 288)
    }
}
