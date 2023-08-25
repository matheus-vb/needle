//
//  WorkspaceCardView.swift
//  NeedleApp
//
//  Created by Bof on 26/07/23.
//

import Foundation
import SwiftUI

struct WorkspaceCardView: View, Identifiable {
<<<<<<< HEAD
    @EnvironmentObject var projectViewModel: ProjectViewModel
    
    @State var isHovered = false
    
    @State private var filteredOwner: [String] = []
    
    var id = UUID()
    var action: () -> Void
    var title: String
    var code: String
    var owner: String
    var workspaceId: String
    let workspace: Workspace

    init(workspaceInfo: Workspace, action: @escaping () -> Void) {
        self.workspaceId = workspaceInfo.id
        self.workspace = workspaceInfo
        self.code = workspaceInfo.accessCode
        self.title = workspaceInfo.name
        self.action = action
        self.owner = workspaceInfo.users[0].user.name
=======
    var id = UUID()
    
    @ObservedObject var workspaceCardViewModel: WorkspaceCardViewModel<AuthenticationManager, TaskDataService, WorkspaceDataService>
    
    init(workspace: Workspace, action: @escaping () -> Void) {
        self.workspaceCardViewModel = WorkspaceCardViewModel(manager: AuthenticationManager.shared, taskDS: TaskDataService.shared, workspaceDS: WorkspaceDataService.shared, action: action, workspace: workspace)
>>>>>>> develop
    }
    
//    var members: String {
//        var membersList: [String] = []
//        for user in projectViewModel.workspaceMembers.values {
//
//        }
//        return membersList.joined(separator: ", ")
//    }
    
    var basicInfo: some View {
<<<<<<< HEAD
        VStack(alignment: .leading, spacing: 16) {
            Text(title).font(.system(size: 24, weight: .medium))
            Text("PM: \(owner)").font(.system(size: 14, weight: .regular))
            //Text("Participantes: \(members)").font(.system(size: 14, weight: .regular))
=======
        VStack(alignment: .leading, spacing: 8) {
            Text(workspaceCardViewModel.workspace.name).font(.custom(SpaceGrotesk.semiBold.rawValue, size: 32)).foregroundColor(Color.theme.blackMain)
            Text("Clique para ver mais deste workspace").font(.custom(SpaceGrotesk.regular.rawValue, size: 12)).foregroundColor(Color.theme.blackMain)
>>>>>>> develop
        }
    }
    
    var deleteButton: some View {
        Button(action: workspaceCardViewModel.action, label: {
            Image(systemName: "trash")
                .foregroundColor(Color.theme.grayHover)
        })
        .buttonStyle(.borderless)
        .modifier(Clickable())
    }
    
    var accessCode: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 3.83)
                .foregroundColor(Color.theme.greenMain)
            Text(workspaceCardViewModel.workspace.accessCode)
        }.frame(width: 88, height: 29)
    }
    
    var body: some View {
<<<<<<< HEAD
        ZStack(alignment: .leading) {
            NavigationLink(destination: ProjectView().environmentObject(projectViewModel), label: {
                RoundedRectangle(cornerRadius: 10).foregroundColor(isHovered ? Color.theme.grayBackground : .white)
=======
        ZStack {
            NavigationLink(destination: ProjectView(selectedWorkspace: workspaceCardViewModel.workspace), label: {
                RoundedRectangle(cornerRadius: 10).foregroundColor(workspaceCardViewModel.isHovered ? Color.theme.grayBackground : .white)
>>>>>>> develop
                    .onHover(perform: { _ in
                        workspaceCardViewModel.isHovered.toggle()
                    })
                    .frame(width: 296, height: 192)
                    .shadow(radius: 4, x: 0, y: 4)
            })
            .simultaneousGesture(TapGesture().onEnded {
                workspaceCardViewModel.selectWorkspace(workspaceId: workspaceCardViewModel.workspace.id)
            })
            .buttonStyle(.plain)
            VStack(alignment: .leading, spacing: 32) {
                basicInfo
                 .foregroundColor(Color.theme.blackMain)
                HStack {
                    Text("Código para convite:").font(.system(size: 12, weight: .medium))
                    Spacer()
                    accessCode
                }.frame(width: 227)
                
            }.padding(.leading, 16)
            .frame(width: 259, height: 155)
            .onAppear {
                    filteredOwner = projectViewModel.filterMembersByRole(role: "PRODUCT_MANAGER")
                        }
        }
    }
}
