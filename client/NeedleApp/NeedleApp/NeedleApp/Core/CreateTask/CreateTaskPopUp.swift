//
//  CreateTaskPopUp.swift
//  NeedleApp
//
//  Created by jpcm2 on 04/08/23.
//

import SwiftUI

struct CreateTaskPopUp: View {
    @StateObject var createTaskViewModel: CreateTaskViewModel = CreateTaskViewModel()
    var geometry: GeometryProxy
    var body: some View {
        VStack(spacing: 30){
            taskTitle
            VStack(alignment: .leading){
                deadLineLabel
                responsibleLabel
                typeLabel
                priorityLabel
            }
        }
        .frame(width: geometry.size.width/3.0, height: geometry.size.height)
        .background(.white)
    }
}

extension CreateTaskPopUp{
    var taskTitle: some View {
        TitleEditableText(text: $createTaskViewModel.taskTitle)
    }
    
    var deadLineLabel: some View {
        HStack{
            Image(systemName: "calendar")
                .resizable()
                .frame(width: 20, height: 20)
            Text("Prazo")
        }
        .font(.system(size: 16))
        .foregroundColor(Color.theme.mainGray)
    }
    
    var responsibleLabel: some View{
        HStack{
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 20, height: 20)
            Text("Responsável")
        }
        .font(.system(size: 16))
        .foregroundColor(Color.theme.mainGray)
    }
    var typeLabel: some View{
        HStack{
            Image(systemName: "shippingbox")
                .resizable()
                .frame(width: 20, height: 20)
            Text("Área")
        }
        .font(.system(size: 16))
        .foregroundColor(Color.theme.mainGray)
    }
    var priorityLabel: some View{
        HStack{
            Image(systemName: "flag.fill")
                .resizable()
                .frame(width: 20, height: 20)
            Text("Prioridade")
        }
        .font(.system(size: 16))
        .foregroundColor(Color.theme.mainGray)
    }
}
