//
//  InformationPageView.swift
//  NeedleApp
//
//  Created by aaav on 01/09/23.
//

import SwiftUI

struct RoleCardInformationPageView: View {
    var role : String
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
            
            VStack (alignment: .leading){
                Text(NSLocalizedString("Minha função", comment: ""))
                    .font(.system(size: 16))
                Text(role)
                    .font(.system(size: 20))
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
                .frame(minWidth: 100, maxWidth: 216)
                .frame(height: 32)
                .background(Color.theme.greenSecondary)
            
            Spacer()
            Text("\(taskNum)")
                .font(.system(size: 32))
                .fontWeight(.bold)
            Spacer()
            
        }
        .frame(maxWidth: 216)
        .frame(height: 104)
        .background(Color.white)
        .cornerRadius(6)
    }
}

struct InformationPageView: View {
    
    @State var isPM : Bool = true
    @State var isActive : Bool = false
    @State var sheetOpened : Bool = false
    
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
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                Spacer()
                
                //                HStack{
                //                    Text("Excluir projeto")
                //                        .font(.system(size: 16))
                //                    Image(systemName: "trash")
                //                }
            }
            
            Text(NSLocalizedString("Informações Gerais",comment:""))
                .font(.system(size: 24))
                .padding(.bottom, 32)
            
            HStack{
                RoleCardInformationPageView(role: getRole())
                //                    .padding(.trailing, 88)
                Spacer()
                Spacer()
                
                OtherCardInformationPageView(cardname: NSLocalizedString("Tasks no Kanban", comment:""), taskNum: informationPageViewModel.tasks.count)
                //                    .padding(.trailing, 25)
                Spacer()
                
                OtherCardInformationPageView(cardname: NSLocalizedString("Tasks Documentadas",comment:""), taskNum: informationPageViewModel.tasks.filter{$0.status == .DONE}.count)
                //                    .padding(.trailing, 25)
                Spacer()
                
                OtherCardInformationPageView(cardname: NSLocalizedString("Tasks Pendentes",comment:""), taskNum: informationPageViewModel.tasks.filter{$0.status != .DONE}.count)
                
            }
            
            Text(NSLocalizedString("Total de membros: ", comment: "") + "\(informationPageViewModel.workspaceMembers.count)")
                .font(.system(size: 24))
                .padding(.top, 54)
                .padding(.bottom, 24)
            
            Table(informationPageViewModel.workspaceMembers, sortOrder: $informationPageViewModel.sortOrder) {
                TableColumn(NSLocalizedString("Nome", comment: ""), value: \.name)
                TableColumn(NSLocalizedString("Email",comment: ""), value: \.email)
                TableColumn(NSLocalizedString("Função", comment: ""), value: \.workspaces![0].userRole.displayName)
                TableColumn(NSLocalizedString("Permanência", comment: "")) { member in
                    if member.workspaces![0].userRole != Role.PRODUCT_MANAGER {
                            HStack{
                                Text("Excluir membro: ")
                                Image(systemName: "trash")
                            }.onTapGesture {
                                informationPageViewModel.updateSelectedMemberId(memberId: member.id)
                                print("memberId: \(member.id)")
                                sheetOpened.toggle()
                            }
                        } else {
                            Text(Role.PRODUCT_MANAGER.displayName)
                        }

                }
            }
            .onChange(of: informationPageViewModel.sortOrder) { newValue in
                informationPageViewModel.workspaceMembers.sort(using: newValue)
            }
            .sheet(isPresented: $sheetOpened, content: {
                SheetView(type: .deleteWorkspaceMember)
                    .foregroundColor(Color.theme.grayHover)
                    .background(.white)
                    .environmentObject(informationPageViewModel)
            })
        }.padding(.horizontal, 60)
    }
    
    func getRole() -> String{
        
        var elementByIdentifier: [String: User] {
            Dictionary(uniqueKeysWithValues: informationPageViewModel.workspaceMembers.map { ($0.id, $0) })
        }
        
        if let role = elementByIdentifier[informationPageViewModel.authManager.user!.id] {
            // Do something with the element
            return role.workspaces![0].userRole.displayName
        } else {
            return "NO ROLE"
        }
        
    }
    
}
