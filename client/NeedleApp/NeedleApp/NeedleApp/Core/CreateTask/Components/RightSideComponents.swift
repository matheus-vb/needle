//
//  RightSideComponents.swift
//  NeedleApp
//
//  Created by jpcm2 on 26/07/23.
//

import SwiftUI


extension RightSide{
    var pickersSection: some View {
        VStack(spacing: 46){
            HStack(spacing: 64){
                Text("Status")
                Picker("Status",selection: $createTaskViewModel.statusSelection){
                    ForEach(TaskStatus.allCases, id: \.self) { status in
                        Text(status.rawValue)
                    }
                }
                .pickerStyle(.menu)
                .labelsHidden()
            }
            
            HStack(spacing: 64){
                Text("Prioridade")
                Picker("Prioridade",selection: $createTaskViewModel.prioritySelection){
                    ForEach(TaskPriority.allCases, id: \.self) { priority in
                        Text(priority.rawValue)
                    }
                }
                .pickerStyle(.menu)
                .labelsHidden()
            }
            
            HStack(spacing: 64){
                Text("Prazo")
                DatePicker(selection: $createTaskViewModel.deadLineSelection, in: Date.now..., displayedComponents: .date) {
                               Text("Select a date")
                }
                .pickerStyle(.menu)
                .labelsHidden()
            }
            
            HStack(spacing: 64){
                Text("Área")
                Picker("Área",selection: $createTaskViewModel.categorySelection){
                    ForEach(TaskType.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }
                .pickerStyle(.menu)
                .labelsHidden()
            }
        }
        .font(.system(size: 16, weight: .bold))
    }
    
    var titleSection: some View{
        VStack{
            Text("Atributos")
                .font(.system(size: 24, weight: .bold))
        }
    }
    
    var buttonsSection: some View{
        HStack(spacing: 56){
            Button(action: {
                print("Botao cancelar")
            }, label: {
                Text("Cancelar")
            })
            Button(action: {
                print("Criar Task")
            }, label: {
                Text("+ Criar")
            })
        }
        .padding([.bottom], 80)
        .padding([.trailing], 50)
    }
}
