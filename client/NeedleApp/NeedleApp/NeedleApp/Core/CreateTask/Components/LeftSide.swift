//
//  LeftSide.swift
//  NeedleApp
//
//  Created by jpcm2 on 26/07/23.
//

import SwiftUI

struct LeftSide: View {
    @EnvironmentObject var createTaskViewModel: CreateTaskViewModel
    let metrics: GeometryProxy
    
    @State var atDescription: Bool = true
    @State var atTemplate: Bool = false
    
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 25){
                title
                buttonsContainer
                contentScreen
                Spacer()
            }
            .padding([.leading, .top], 124)
        }
        .frame(width: metrics.size.width*0.7, height: metrics.size.height)
        .background(.blue)
    }
}

extension LeftSide{
    var descriptionButton: some View{
        Button(action: {
            print("Botao de descricao")
            atTemplate.toggle()
            atDescription.toggle()
        }, label: {
            Text("Descrição")
        })
    }
    
    var templateButton: some View{
        Button(action: {
            print("Botao de descricao")
            atTemplate.toggle()
            atDescription.toggle()
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
        TitleEditableText(text: $createTaskViewModel.taskTitle)
    }
    
    var contentScreen: some View {
        VStack{
            if(atTemplate){
                VStack{
                    Text("AQUI DEVERIA APARECER A VIEW DOS TEMPLATES ;)))")
                }
            }else if(atDescription){
                TextEditor(text: $createTaskViewModel.taskDescription)
                    .scrollContentBackground(.hidden)
                    .frame(width: metrics.size.width*0.5, height:  metrics.size.width*0.3)
                    .padding([.leading, .top], 24)
                    .background(.gray)
                    .font(.system(size: 20, weight: .regular))
            }
        }
    }
}
