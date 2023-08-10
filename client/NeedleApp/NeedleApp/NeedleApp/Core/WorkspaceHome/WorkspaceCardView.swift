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
    
    var id = UUID()
    var action: () -> Void
    var title: String
    var code: String
    var owner: String
    var workspaceId: String
    let workspace: Workspace

    init(workspaceInfo: Workspace, action: @escaping () -> Void) {
        self.title = workspaceInfo.name
        self.action = action
        self.owner = "quem"
        self.code = workspaceInfo.accessCode
        self.workspaceId = workspaceInfo.id
        self.workspace = workspaceInfo
    }
    
    var basicInfo: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title).font(.custom(SpaceGrotesk.semiBold.rawValue, size: 32)).foregroundColor(Color.theme.blackMain)
            Text("Clique para ver mais deste workspace").font(.custom(SpaceGrotesk.regular.rawValue, size: 12)).foregroundColor(Color.theme.blackMain)
        }
    }
    
    var deleteButton: some View {
        Button(action: action, label: {
            Text("􀈑")
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
        ZStack {
            NavigationLink(destination: ProjectView().environmentObject(projectViewModel), label: {
                RoundedRectangle(cornerRadius: 10).foregroundColor(isHovered ? Color.theme.grayBackground : .white)
                    .onHover(perform: { _ in
                        isHovered.toggle()
                    })
                    .frame(width: 488, height: 283.96)
                    .shadow(radius: 10, x: 0, y: 4)
            })
            .simultaneousGesture(TapGesture().onEnded {
                AuthenticationManager.shared.getRoleInWorkspace(userId: AuthenticationManager.shared.user!.id, workspaceId: workspaceId)
                TaskDataService.shared.getWorkspaceTasks(userId: AuthenticationManager.shared.user!.id, workspaceId: workspace.id)
                WorkspaceDataService.shared.getWorkspaceMembers(workspaceId: workspaceId)
                projectViewModel.selectedProject = workspace
            })
            .buttonStyle(.plain)
            VStack(alignment: .trailing) {
                HStack {
                    basicInfo
                    Spacer()
                    deleteButton
                }
                Spacer()
                accessCode
                
            }.padding(24)
        }
    }
}
