//
//  RightSide.swift
//  NeedleApp
//
//  Created by jpcm2 on 26/07/23.
//

import SwiftUI

struct RightSide: View {
    let metrics: GeometryProxy
    
    let statusOp = ["1", "2", "3"]
    @State var statusSelection: String = "1"
    @State var prioritySelection: String = "1"
    @State var deadLineSelection = Date.now
    
    var body: some View {
        VStack(alignment: .leading, spacing: 80){
            Text("Atributos")
                .font(.system(size: 24, weight: .bold))
            VStack(spacing: 46){
                HStack(spacing: 64){
                    Text("Status")
                    Picker("Status",selection: $statusSelection){
                        ForEach(statusOp, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    .labelsHidden()
                }
                
                HStack(spacing: 64){
                    Text("Prioridade")
                    Picker("Prioridade",selection: $prioritySelection){
                        ForEach(statusOp, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    .labelsHidden()
                }
                
                HStack(spacing: 64){
                    Text("Prazo")
                    DatePicker(selection: $deadLineSelection, in: ...Date.now, displayedComponents: .date) {
                                   Text("Select a date")
                    }
                    .pickerStyle(.menu)
                    .labelsHidden()
                }
                
                HStack(spacing: 64){
                    Text("Área")
                    Picker("Área",selection: $statusSelection){
                        ForEach(statusOp, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    .labelsHidden()
                }
            }
            .font(.system(size: 16, weight: .bold))
            Spacer()
        }
        .padding([.top], 124)
        .padding([.leading], 87)
        .padding([.trailing], 50)
        .frame(width: metrics.size.width*0.3, height: metrics.size.height)
        .background(.red)
    }
}
