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
                    ForEach(createTaskViewModel.statusOp, id: \.self){
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
                .labelsHidden()
            }
            
            HStack(spacing: 64){
                Text("Prioridade")
                Picker("Prioridade",selection: $createTaskViewModel.prioritySelection){
                    ForEach(createTaskViewModel.priorityOp, id: \.self){
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
                .labelsHidden()
            }
            
            HStack(spacing: 64){
                Text("Prazo")
                DatePicker(selection: $createTaskViewModel.deadLineSelection, in: ...Date.now, displayedComponents: .date) {
                               Text("Select a date")
                }
                .pickerStyle(.menu)
                .labelsHidden()
            }
            
            HStack(spacing: 64){
                Text("Área")
                Picker("Área",selection: $createTaskViewModel.categorySelection){
                    ForEach(createTaskViewModel.categoryOp, id: \.self){
                        Text($0)
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
}
