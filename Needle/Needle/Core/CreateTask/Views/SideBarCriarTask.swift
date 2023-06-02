//
//  SideBarCriarTask.swift
//  Needle
//
//  Created by gabrielfelipo on 31/05/23.
//

import SwiftUI

struct SideBarCriarTask: View {
    
    var workspace: WorkspaceModel
    
    @State var newTask: TaskModel
    
    @State var statusChoice = "Selecione"
    
    @State var areaChoice = "Selecione"
    
    @State var memberChoice = "Selecione"
    
    @State private var date = Date()
    
    @State private var tags = ""
    
    @Binding var cancelled: Bool
    
    let workspaceId: String
    let title: String
    let description: String
    let accessCode: String
    
    let taskService = TaskService(baseUrl: _URL)
    
    var body: some View {
        ScrollView{
            VStack{
                
                titleSideBarCriarTask
                
                Rectangle().frame(height: 2)
                    .foregroundColor(.white)
                
                Spacer().frame(height: 50)
                VStack(spacing: 38){
                    HStack{
                        Text("Status")
                            .frame(width: 150, alignment: .leading)
                            .font(.custom(.spaceGroteskBold, size: 24))
                        attributeDropdownStatus
                    }
                    
                    HStack{
                        Text("Prazo")
                            .frame(width: 150, alignment: .leading)
                            .font(.custom(.spaceGroteskBold, size: 24))
                        
                        DatePicker(
                            "",
                            selection: $date,
                            displayedComponents: [.date]
                        ).frame(width: 150)
                    }
                    
                    HStack{
                        Text("Área")
                            .frame(width: 150, alignment: .leading)
                            .font(.custom(.spaceGroteskBold, size: 24))
                        attributeDropdownArea
                    }
                    
                    HStack{
                        Text("Atribuir")
                            .frame(width: 150, alignment: .leading)
                            .font(.custom(.spaceGroteskBold, size: 24))
                        attributeDropdownMember
                    }
                    
                    VStack{
                        Text("+ Adicionar Tags")
                            .font(.custom(.spaceGroteskBold, size: 24))
                        
                        TextField("ex: API, dados, design system, etc", text: $tags)
                            .onChange(of: tags)  { newValue in
                                //newTask.taskTag = tags
                            }
                            .frame(width: 427)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 32){
                        Button(action: {
                            cancelled.toggle()
                        }, label: {
                            Text("Cancelar")
                                .font(.custom(.spaceGrotesk, size: 18))
                        }).buttonStyle(CriarButtonStyle(fontColor: .white, bgColor: .clear))
                        
                        Button(action: {
                            let taskToAdd = TaskModel(id: nil, title: title, description: description, status: "TODO", type: areaChoice, documentId: nil, endDate: "2000-01-01T04:00:00.000Z", workId: workspaceId)
                            
                            print(taskToAdd)
                            
                            taskService.createTask(accessCode: accessCode, taskInput: taskToAdd) { _ in
                            }
                            
                            Task {
                                try? await Task.sleep(nanoseconds: 250_000_000)
                                cancelled.toggle()
                            }
                            
                            
                        }, label: {
                            Text("+ Criar")
                                .font(.custom(.spaceGrotesk, size: 18))
                        }).buttonStyle(CriarButtonStyle(fontColor: .black, bgColor: Color.color.mainGreen))
                    }
                    Spacer().frame(height: 77)
                }
            }.frame(maxWidth: 584)
        }.background(Color.color.mainBlack)
    }
    
}

