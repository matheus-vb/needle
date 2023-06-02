//
//  CreateTaskView.swift
//  Needle
//
//  Created by gabrielfelipo on 31/05/23.
//

import SwiftUI

struct CreateTaskView: View {
    @State private var descriptionText = String()
    
    @State var choice: status = .description
    
    @State private var title = "titulo"
    
    @State var newTask: Task = Task(id: "1", title: "", description: "", status: "", type: "", documentId: "1", endDate: "", workId: "1", userId: "", taskTag: "")
    
    var workspace: WorkspaceModel = WorkspaceModel(id: "1", accessCode: "123", name: "workspace teste", users:[
        User(id: "1", role: "Design", name: "Flipo", email: "gfrm"),User(id: "2", role: "dev", name: "Meidoras", email: "mdrs")
    ])
    
    @State var textTemplate: String = "1. Descrição da Task (2 linhas máximo)\n\n2. Detalhes de Implementação\n\n3. Referências de Códio\n\n4. Teste\n\n5. Desafios e Soluções\n\n6. Referências\n\n"
    
    enum status: String, CaseIterable {
        case description = "Descrição"
        case template = "template"
    }
    
    var body: some View {
        HStack{
            Spacer()
            VStack{
                Spacer().frame(height: 32)
                HStack(spacing: 8){
                    Spacer().frame(width: 24)
                    Text(title)
                        .font(.custom(.spaceGrotesk, size: 40))
                        .foregroundColor(.black)
                    
                    TextField("Titulo", text: $title)
                        .onChange(of: title)  { newValue in
                            newTask.title = title
                        }
                        .foregroundColor(.black)
                        .background(Color.color.kanbanGrayLOWOPACITY)
                }
                
                dropdownChoice
                
                if choice == .description {
                    TextEditor(text: $descriptionText)
                        .scrollContentBackground(.hidden)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.color.kanbanGrayLOWOPACITY)
                        .frame(minWidth: 10, maxWidth: 648, minHeight: 200 ,maxHeight: 416)
                        .cornerRadius(20)
                }
                else {
                    DocumentView(text: NSAttributedString(string: textTemplate, attributes: [.font: NSFont.systemFont(ofSize: 24), .foregroundColor: NSColor(.white)])).background(Color.color.mainBlack)
                }
                Spacer()
            }
            Spacer()
            
            SideBarCriarTask(workspace: workspace, newTask: newTask).shadow(radius: 8)
        }.background(Color.color.backgroundGray)
    }
    
    var dropdownChoice: some View {
        Menu{
            
            ForEach (status.allCases, id: \.self){ statusCase in
                
                Button(statusCase.rawValue){
                    choice = statusCase
                }
            }
        } label: {
            ZStack{
                
                Text(choice.rawValue)
                    .font(.custom(.spaceGroteskBold, size: 13))
                
            }.frame(width: 50, height: 100)
        }.menuStyle(menuCreateStyle())
    }
    
    struct menuCreateStyle: MenuStyle {
        func makeBody(configuration: Configuration) -> some View {
            Menu(configuration)
                .foregroundColor(.white)
                .background(.black, in: RoundedRectangle(cornerRadius: 4, style: .continuous))
                .frame(width: 150)
        }
    }
}

struct CreateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTaskView()
    }
}
