//
//  WorkspaceCardView.swift
//  NeedleApp
//
//  Created by Bof on 26/07/23.
//

import Foundation
import SwiftUI

struct WorkspaceCardView: View, Identifiable {
    @EnvironmentObject var projectViewModel: ProjectViewModel
    
    @State var isHovered = false
    
    @State private var filteredOwner: [String] = []
    
    var id = UUID()
    var action: () -> Void
    var title: String
    var code: String
    var owner: [String]
    var workspaceId: String
    let workspace: Workspace

    init(workspaceInfo: Workspace, action: @escaping () -> Void) {
        self.code = workspaceInfo.accessCode
        self.title = workspaceInfo.name
        self.action = action
        self.owner = [""] // criar rota pra pegar owner
        self.workspaceId = workspaceInfo.id
        self.workspace = workspaceInfo
    }
    
    var basicInfo: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title).font(.system(size: 24, weight: .medium))
            Text("PM: \(filteredOwner.joined())").font(.system(size: 14, weight: .regular))
            Text("Participantes: ").font(.system(size: 14, weight: .regular))
        }
    }
    
    var deleteButton: some View {
        Button(action: action, label: {
            Image(systemName: "trash")
                .foregroundColor(Color.theme.grayHover)
        })
        .buttonStyle(.borderless)
    }
    
    var accessCode: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 3.83)
                .foregroundColor(Color.theme.greenMain)
            Text(code)
        }.frame(width: 88, height: 29)
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            NavigationLink(destination: ProjectView().environmentObject(projectViewModel), label: {
                RoundedRectangle(cornerRadius: 10).foregroundColor(isHovered ? Color.theme.grayBackground : .white)
                    .onHover(perform: { _ in
                        isHovered.toggle()
                    })
                    .frame(width: 296, height: 192)
                    .shadow(radius: 4, x: 0, y: 4)
            })
            .simultaneousGesture(TapGesture().onEnded {
                AuthenticationManager.shared.getRoleInWorkspace(userId: AuthenticationManager.shared.user!.id, workspaceId: workspaceId)
                TaskDataService.shared.getWorkspaceTasks(userId: AuthenticationManager.shared.user!.id, workspaceId: workspace.id)
                WorkspaceDataService.shared.getWorkspaceMembers(workspaceId: workspaceId)
                projectViewModel.selectedProject = workspace
            })
            .buttonStyle(.plain)
            VStack(alignment: .trailing) {
                HStack(spacing: 32) {
                    basicInfo
                        .foregroundColor(Color.theme.blackMain)
                    Spacer()
                }
                Spacer()
                HStack{
                    Text("Código para convite:")
                    Spacer()
                    accessCode
                }
                
            }.padding(.leading, 16)
            .frame(width: 259, height: 155)
            .onAppear {
                    filteredOwner = projectViewModel.filterMembersByRole(role: "PRODUCT_MANAGER")
                        }
        }
    }
}
