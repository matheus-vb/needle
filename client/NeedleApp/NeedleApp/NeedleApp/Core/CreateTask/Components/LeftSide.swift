//
//  LeftSide.swift
//  NeedleApp
//
//  Created by jpcm2 on 26/07/23.
//

import SwiftUI

struct LeftSide: View {
    let metrics: GeometryProxy
    @State var taskDescription: String = ""
    var body: some View {
        VStack{
            Text("Task 1")
            Button(action: {
                print("Botao de descricao")
            }, label: {
                Text("Descrição")
            })
            
            Button(action: {
                print("Botao de template")
            }, label: {
                Text("Template")
            })
            
            TextField("Description", text: $taskDescription)
        }
        .frame(width: metrics.size.width*0.7, height: metrics.size.height)
        .background(.blue)
    }
}
