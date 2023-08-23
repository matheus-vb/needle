//
//  WorkspaceCardView.swift
//  NeedleApp
//
//  Created by Bof on 26/07/23.
//

import Foundation
import SwiftUI

struct WorkspaceCardView: View, Identifiable {
    var id = UUID()
    
    @ObservedObject var workspaceCardViewModel: WorkspaceCardViewModel<AuthenticationManager, TaskDataService, WorkspaceDataService>
    
    init(workspace: Workspace, action: @escaping () -> Void) {
        self.workspaceCardViewModel = WorkspaceCardViewModel(manager: AuthenticationManager.shared, taskDS: TaskDataService.shared, workspaceDS: WorkspaceDataService.shared, action: action, workspace: workspace)
    }
    
    var basicInfo: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(workspaceCardViewModel.workspace.name).font(.custom(SpaceGrotesk.semiBold.rawValue, size: 32)).foregroundColor(Color.theme.blackMain)
            Text("Clique para ver mais deste workspace").font(.custom(SpaceGrotesk.regular.rawValue, size: 12)).foregroundColor(Color.theme.blackMain)
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
                RoundedRectangle(cornerRadius: 10).foregroundColor(workspaceCardViewModel.isHovered ? Color.theme.grayBackground : .white)
                    .onHover(perform: { _ in
                        workspaceCardViewModel.isHovered.toggle()
                    })
                    .frame(width: 488, height: 283.96)
                    .shadow(radius: 10, x: 0, y: 4)
            })
            .simultaneousGesture(TapGesture().onEnded {
                workspaceCardViewModel.selectWorkspace(workspaceId: workspaceCardViewModel.workspace.id)
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
