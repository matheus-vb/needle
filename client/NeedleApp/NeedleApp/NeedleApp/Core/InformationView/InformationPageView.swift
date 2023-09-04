//
//  InformationPageView.swift
//  NeedleApp
//
//  Created by aaav on 01/09/23.
//

import SwiftUI

struct Information: Identifiable {
    let id  = UUID()
    let name : String
    let area: String
    let last_access: String
    let status: String
}

struct RoleCardInformationPageView: View {
    var body: some View{
        HStack{
            Group{
                Image(systemName: "person")
                    .resizable()
                    .foregroundColor(Color.theme.blackMain)
                    .frame(width: 57, height: 57)
            }
            .frame(width: 80, height: 104)
            .background(Color.theme.greenSecondary)
            
            Spacer()
            VStack{
                Text("Minha função")
                    .font(.system(size: 16))
                Text("PM")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                
            }
            Spacer()
            
        }
        .frame(width: 216, height: 104)
        .background(Color.white)
        .cornerRadius(6)
        
    }
}


struct OtherCardInformationPageView: View {
    let cardname : String
    let taskNum : Int
    var body: some View{
        VStack{
            Text(cardname)
                .font(.system(size: 16))
                .frame(width: 216, height: 32)
                .background(Color.theme.greenSecondary)
            
            Spacer()
            Text("\(taskNum)")
                .font(.system(size: 32))
                .fontWeight(.bold)
            Spacer()
            
        }
        .frame(width: 216, height: 104)
        .background(Color.white)
        .cornerRadius(6)
        
    }
}

struct InformationPageView: View {
    
    @ObservedObject var searchDocumentsViewModel: SearchDocumentsViewModel<TaskDataService>

    init(tasks: [TaskModel]?, workspaceId: String, selectedTask: Binding<TaskModel?>, isEditing: Binding<Bool>) {

        self.searchDocumentsViewModel = SearchDocumentsViewModel(
            tasks: tasks ?? [],
            workspaceId: workspaceId,
            selectedTask: selectedTask,
            isEditing: isEditing,
            taskDS: TaskDataService.shared
        )
    }
    
    
    @State private var informations :  [Information] = [
        Information(name: "A", area: "A", last_access: "A", status: "A"),
        Information(name: "D", area: "B", last_access: "B", status: "B"),
        Information(name: "C", area: "C", last_access: "C", status: "C"),
        Information(name: "D", area: "D", last_access: "D", status: "D")
    ]
    
    @State var showOn : Bool = true
    @State private var sortOrder = [KeyPathComparator(\Information.name)]
    
    var body: some View {
        
        VStack(alignment: .leading){
            HStack{
                Text("Projeto \(9)")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .padding(.vertical, 40)
                Spacer()
                
                HStack{
                    Text("Excluir projeto")
                        .font(.system(size: 16))
                    Image(systemName: "trash")
                }
            }
            
            Text("Informações Gerais")
                .font(.system(size: 24))
                .padding(.bottom, 32)

            HStack{
                RoleCardInformationPageView()
                    .padding(.trailing, 88)
                Spacer()
                OtherCardInformationPageView(cardname: "Tasks no Kanban", taskNum: 20)
                    .padding(.trailing, 32)
                OtherCardInformationPageView(cardname: "Tasks Documentadas", taskNum: 15)
                    .padding(.trailing, 32)
                OtherCardInformationPageView(cardname: "Tasks Pendentes", taskNum: 5)
                    
            }
                        
            Text("Total de membros: \(informations.count)" )
                .font(.system(size: 24))
                .padding(.top, 54)
                .padding(.bottom, 24)

            Table(informations) {
                TableColumn("Nome", value: \.name)
                TableColumn("Área", value: \.area)
                TableColumn("Último acesso", value: \.last_access)
                TableColumn("Status"){
                    Text("\($0.status)")
                }
            }
            
        }
    }
}

//struct InformationPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        InformationPageView()
//            .frame(minWidth: 1100, minHeight: 600)
//    }
//}
