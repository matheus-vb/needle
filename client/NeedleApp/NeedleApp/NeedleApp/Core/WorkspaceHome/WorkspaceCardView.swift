//
//  WorkspaceCardView.swift
//  NeedleApp
//
//  Created by Bof on 26/07/23.
//

import Foundation
import SwiftUI

struct WorkspaceCardView: View, Identifiable {
    @ObservedObject var workspaceCardViewModel: WorkspaceCardViewModel<AuthenticationManager, TaskDataService, WorkspaceDataService>

//    @State var isHovered = false
    
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
        self.workspaceCardViewModel = WorkspaceCardViewModel(manager: AuthenticationManager.shared, taskDS: TaskDataService.shared, workspaceDS: WorkspaceDataService.shared, action: action, workspace: workspace)
    }
    
    
    var basicInfo: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title).font(.system(size: 24, weight: .medium))
            Text("PM: \(owner)").font(.system(size: 14, weight: .regular))
            //Text("Participantes: \(members)").font(.system(size: 14, weight: .regular))
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
        ZStack {
            NavigationLink(destination: ProjectView(selectedWorkspace: workspaceCardViewModel.workspace), label: {
                RoundedRectangle(cornerRadius: 10)
                    .modifier(workspaceCardModifier(standardColor: .white, hoveredColor: Color.theme.grayBackground))
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
                    CopyClipboardButton(text: code, isOnCard: true) {
                    }
                }.frame(width: 227)
                
            }.padding(.leading, 16)
            .frame(width: 259, height: 155)
        }
    }
}
