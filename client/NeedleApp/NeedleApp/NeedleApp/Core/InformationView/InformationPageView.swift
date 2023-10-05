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
    
    @State var sheetOpened : Bool = false
    @State var deleteSheetOpened : Bool = false
    @Environment(\.dismiss) var dismiss

    
    @ObservedObject var informationPageViewModel: InformationPageViewModel<TaskDataService, WorkspaceDataService, AuthenticationManager>
    
    init(tasks: [TaskModel]?, workspaceMembers: [User]?, workspace: Workspace) {
        
        self.informationPageViewModel = InformationPageViewModel(
            tasks: tasks  ?? [],
            workspaceMembers: workspaceMembers ?? [],
            workspace: workspace,
            workspaceDS: WorkspaceDataService.shared,
            taskDS: TaskDataService.shared,
            authManager: AuthenticationManager.shared
        )
    }
    
    
    var body: some View {
        
        VStack(alignment: .leading){
            HStack{
                Text(informationPageViewModel.workspace.name)
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                Spacer()
                
                DashedExcludeButton(text: NSLocalizedString("Excluir projeto", comment: "")){
//                    informationPageViewModel.deleteWorkspace()
                    deleteSheetOpened.toggle()
//                    dismiss()
                }
                .sheet(isPresented: $deleteSheetOpened, content: {
                    SheetView(type: .deleteWorkspaceFromInfo)
                        .foregroundColor(Color.theme.grayHover)
                        .background(.white)
                        .environmentObject(informationPageViewModel)
                })
            }
            
            Text(NSLocalizedString("Informações Gerais",comment:""))
                .font(.system(size: 24))
                .padding(.bottom, 32)
            
            HStack{
                RoleCardInformationPageView(role: getRole().displayName)
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
                .padding(.vertical, 26)
            
            if getRole() == Role.PRODUCT_MANAGER {
                PMTable()
            } else {
                memberTable()
            }
            
        }.padding(.horizontal, 60)
    }
    
    func getRole() -> Role {
        
        var elementByIdentifier: [String: User] {
            Dictionary(uniqueKeysWithValues: informationPageViewModel.workspaceMembers.map { ($0.id, $0) })
        }
        
        if let role = elementByIdentifier[informationPageViewModel.authManager.user!.id] {
            // Do something with the element
            return role.workspaces![0].userRole
        } else {
            return Role.PRODUCT_MANAGER
        }
        
    }
    
}

extension InformationPageView{
    @ViewBuilder
    func PMTable() -> some View {
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
        .padding(.bottom, 25)
        .onChange(of: informationPageViewModel.sortOrder) { newValue in
            informationPageViewModel.workspaceMembers.sort(using: newValue)
        }
        .sheet(isPresented: $sheetOpened, content: {
            SheetView(type: .deleteWorkspaceMember)
                .foregroundColor(Color.theme.grayHover)
                .background(.white)
                .environmentObject(informationPageViewModel)
        })
    }
    
    func memberTable() -> some View {
        Table(informationPageViewModel.workspaceMembers, sortOrder: $informationPageViewModel.sortOrder) {
            TableColumn(NSLocalizedString("Nome", comment: ""), value: \.name)
            TableColumn(NSLocalizedString("Email",comment: ""), value: \.email)
            TableColumn(NSLocalizedString("Função", comment: ""), value: \.workspaces![0].userRole.displayName)
        }
        .onChange(of: informationPageViewModel.sortOrder) { newValue in
            informationPageViewModel.workspaceMembers.sort(using: newValue)
        }
    }
    
}
