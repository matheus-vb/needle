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
    @State var taskTitle: String = "Task 1"
    
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 25){
                title
                buttonsContainer
                TextField("Adicione uma breve descrição do projeto", text: $taskDescription)
            }
            .padding([.leading], 124)
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
    
    var title: some View {
        EditableText(text: $taskTitle)
    }
}
