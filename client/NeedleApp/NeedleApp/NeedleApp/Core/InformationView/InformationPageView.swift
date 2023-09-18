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
    var status: Bool
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
    
    @State private var informations :  [Information] = [
        Information(name: "A", area: "A", last_access: "A", status: true),
        Information(name: "B", area: "B", last_access: "B", status: false),
        Information(name: "C", area: "C", last_access: "C", status: false),
        Information(name: "D", area: "D", last_access: "D", status: true)
    ]
    
    @State var isPM : Bool = true
    @State var isActive : Bool = false
    @State private var sortOrder = [KeyPathComparator(\Information.name)]
    
    @ObservedObject var informationPageViewModel: InformationPageViewModel<TaskDataService, WorkspaceDataService, AuthenticationManager>
    
    init(tasks: [TaskModel]?, workspaceMembers: [User]?, workspaceId: String, workspaceName: String) {
        
        self.informationPageViewModel = InformationPageViewModel(
            tasks: tasks  ?? [],
            workspaceMembers: workspaceMembers ?? [],
            workspaceId: workspaceId,
            workspaceName: workspaceName,
            workspaceDS: WorkspaceDataService.shared,
            taskDS: TaskDataService.shared,
            authManager: AuthenticationManager.shared
        )
    }
    
    
    var body: some View {
        
        VStack(alignment: .leading){
            HStack{
                Text(informationPageViewModel.workspaceName)
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
//                    .padding(.trailing, 88)
                Spacer()
                Spacer()
                
                OtherCardInformationPageView(cardname: "Tasks no Kanban", taskNum: informationPageViewModel.tasks.count)
//                    .padding(.trailing, 25)
                Spacer()

                OtherCardInformationPageView(cardname: "Tasks Documentadas", taskNum: informationPageViewModel.tasks.filter{$0.status == .DONE}.count)
//                    .padding(.trailing, 25)
                Spacer()

                OtherCardInformationPageView(cardname: "Tasks Pendentes", taskNum: informationPageViewModel.tasks.filter{$0.status != .DONE}.count)
                    
            }
                        
            Text("Total de membros: \(informationPageViewModel.workspaceMembers.count)" )
                .font(.system(size: 24))
                .padding(.top, 54)
                .padding(.bottom, 24)

//            Table(informations, sortOrder: $sortOrder) {
//                TableColumn("Nome", value: \.name)
//                TableColumn("Área", value: \.area)
//                TableColumn("Último acesso", value: \.last_access)
//                TableColumn("Status", value: \.status.description) { info in
//
//                    if isPM {
//                        HStack{
//                            Toggle("", isOn: Binding<Bool>(
//                                get: {
//                                    return info.status
//                                }, set: {
//                                    if let index = informations.firstIndex(where: { $0.id == info.id }) {
//                                        informations[index].status = $0
//                                    }
//                                }
//                            )).toggleStyle(SwitchToggleStyle(tint: .green))
//                            Text(info.status ? "Ativo" : "Inativo")
//
//                        }
//                    } else {
//                        Image(systemName: "flag.fill")
//                            .foregroundColor(isActive ? Color.theme.greenKanban : Color.theme.redMain)
//                    }
//                }
//            }
//            .onChange(of: sortOrder) { newValue in
//                informations.sort(using: newValue)
//            }
//            Table(informationPageViewModel.workspace) {
//                TableColumn("Nome", value: \.workspaceMembers)
//                TableColumn("Área", value: \.area)
//                TableColumn("Último acesso", value: \.last_access)
//                TableColumn("Status", value: \.status.description)
//
//            }
//            .onChange(of: sortOrder) { newValue in
//                informations.sort(using: newValue)
//            }
        }.padding()
    }
}
