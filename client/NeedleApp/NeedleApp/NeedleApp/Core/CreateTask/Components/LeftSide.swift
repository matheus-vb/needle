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
            buttonsContainer
            TextField("Description", text: $taskDescription)
        }
        .frame(width: metrics.size.width*0.7, height: metrics.size.height)
        .background(.blue)
    }
}

extension LeftSide{
    var descriptionButton: some View{
        Button(action: {
            print("Botao de descricao")
        }, label: {
            Text("Descrição")
        })
    }
    
    var templateButton: some View{
        Button(action: {
            print("Botao de descricao")
        }, label: {
            Text("Template")
        })
    }
    
    var buttonsContainer: some View{
        HStack(spacing: 30){
            descriptionButton
            templateButton
        }
    }
}
