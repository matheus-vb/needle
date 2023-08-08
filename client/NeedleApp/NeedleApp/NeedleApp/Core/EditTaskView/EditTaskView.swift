//
//  EditTaskView.swift
//  NeedleApp
//
//  Created by jpcm2 on 08/08/23.
//

import SwiftUI

struct EditTaskPopUP: View {
    @StateObject var editTaskViewModel: EditTaskViewModel = EditTaskViewModel(taskDescription: "", taskTitle: "Titulo da Task", statusSelection: TaskStatus.IN_PROGRESS, prioritySelection: TaskPriority.LOW, categorySelection: TaskType.DEV, selectedMember: WorkspaceUser(id: "1", name: "Medeiros"), documentationString: NSAttributedString(string: "ola"))
    var geometry: GeometryProxy
    var body: some View {
        ScrollView{
            VStack(spacing: 24){
                topSection
                contentStack
            }
        }
        .scrollIndicators(.hidden)
        .padding([.leading, .trailing], 64)
        .padding([.top, .bottom],32)
        .frame(width: 4*geometry.size.width/9.0, height: geometry.size.height)
        .background(.white)
    }
}

struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ geometry in
            EditTaskPopUP(geometry: geometry)
        }
       
    }
}


extension EditTaskPopUP{
    var taskTitle: some View {
        TitleEditableText(text: $editTaskViewModel.taskTitle)
    }
    var deadLine: some View{
        HStack(spacing: 24){
            LabelComponent(imageName: "calendar", label: "Prazo")
            DatePicker(selection: $editTaskViewModel.deadLineSelection, in: Date.now..., displayedComponents: .date) {
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
            Picker("Prioridade",selection: $editTaskViewModel.prioritySelection){
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
            TextEditor(text: $editTaskViewModel.taskDescription)
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(Color.theme.grayPressed)
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
            Spacer()
            Button(action: {
                print("Fechar")
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
        
    }
    
    func saveTaskButton(){
        
    }
}
