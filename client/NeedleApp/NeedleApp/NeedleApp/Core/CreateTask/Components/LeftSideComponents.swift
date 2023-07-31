//
//  LeftSideComponents.swift
//  NeedleApp
//
//  Created by jpcm2 on 26/07/23.
//

import SwiftUI

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
                    EditDocumentationView(documentation: $createTaskViewModel.documentationString)
                        .environmentObject(createTaskViewModel)
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
