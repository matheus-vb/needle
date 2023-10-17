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
            PopUpButton(text: NSLocalizedString("Cancelar", comment: ""), onButtonTapped: cancelButton)
            Button(action: {
                goToChooseDoc = true
            }, label:{
                Text(NSLocalizedString("Continuar", comment: ""))
                    .padding([.top, .bottom], 9)
                    .frame(width: 104)
                    .background(Color.theme.greenMain)
                    .font(.custom(SpaceGrotesk.regular.rawValue, size: 12))
                    .cornerRadius(8)
                    
            })
            .buttonStyle(.plain)
            .modifier(Clickable())
        }
    }
    
    func cancelButton(){
        createTaskViewModel.showPopUp.toggle()
    }
    
    func createTaskButton(){
        createTaskViewModel.createTask()
        createTaskViewModel.showPopUp.toggle()
    }
    
    func goToChooseDocFunc(){
        self.goToChooseDoc.toggle()
    }

    var header: some View {
        VStack {
            HStack {
                Button(action: {
                    goToChooseDoc = false
                }, label: {Text("􀰪")})
                    .foregroundColor(.black)
                    .buttonStyle(.borderless)
                Spacer()
                Button(action: {
                    createTaskViewModel.showPopUp.toggle()
                }, label: {Text("􀆄")})
                    .foregroundColor(.black)
                    .buttonStyle(.borderless)
            }.padding(.top, 16)
                .padding(.horizontal, 32)
            VStack(alignment: .center, spacing: 10) {
                Text(NSLocalizedString("Configure sua documentação", comment: ""))
                    .font(Font.custom("SF Pro", size: 24).weight(.medium))
                Text(NSLocalizedString("Escolha seu Template", comment: ""))
                    .font(Font.custom("SF Pro", size: 20).weight(.regular))
                
            }
        }
    }
    
    var content: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(NSLocalizedString("Modelos disponíveis", comment: ""))
                    .font(Font.custom("SF Pro", size: 16).weight(.semibold))
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        ForEach(TemplateArea.allCases, id: \.rawValue) { area in
                            VStack(alignment: .leading, spacing: 16) {
                                Text(area.areaName)
                                ForEach(TemplateType.allCases.filter({ $0.info.area == area }), id: \.rawValue) { item in
                                    Button(action: {
                                        createTaskViewModel.chosenTemplate = item
                                    }, label: {
                                        Text(item.info.name)
                                    }).buttonStyle(ChooseTemplateButton())
                                }
                            }
                        }
                    }.padding(.trailing, 20)
                        .foregroundColor(.black)
                }
            }.padding(.top, 16)
                .padding(.leading, 24)
            Divider()
                .padding(.horizontal, 24)
            VStack(alignment: .trailing, spacing: 32) {
                templateVisualizer
                //                        .frame(width: geometry.size.width*0.60)
                    .padding(.leading, 4)
                createButton
                Spacer()
            }.padding(.top, 16)
            Spacer()
                .frame(width: 20)
        }
    }
    
    
    var templateVisualizer: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(NSLocalizedString("Pré-visualização:", comment: "")).font(Font.custom("SF Pro", size: 16)
                .weight(.semibold)) + Text(" ")
            + Text(createTaskViewModel.chosenTemplate.info.name).font((Font.custom("SF Pro", size: 16).weight(.semibold)))
            Image(createTaskViewModel.chosenTemplate.info.img)
                .resizable()
                .scaledToFit()
        }
    }
    
    
    var createButton: some View {
        Button(action: { 
            createTaskViewModel.createTask()
            createTaskViewModel.showPopUp.toggle()
        }, label: {
                Text(NSLocalizedString("Criar", comment: ""))
            })
        .buttonStyle(CreateTemplateButton())
    }
}
