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
    
    @ObservedObject var workspaceViewModel: WorkspaceCardViewModel<AuthenticationManager, TaskDataService, WorkspaceDataService>
    
    @EnvironmentObject var projectViewModel: ProjectViewModel
    
    init(workspace: Workspace, action: @escaping () -> Void) {
        self.workspaceViewModel = WorkspaceCardViewModel(manager: AuthenticationManager.shared, taskDS: TaskDataService.shared, workspaceDS: WorkspaceDataService.shared, action: action, workspace: workspace)
    }
    
    var basicInfo: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(workspaceViewModel.workspace.name).font(.custom(SpaceGrotesk.semiBold.rawValue, size: 32)).foregroundColor(Color.theme.blackMain)
            Text("Clique para ver mais deste workspace").font(.custom(SpaceGrotesk.regular.rawValue, size: 12)).foregroundColor(Color.theme.blackMain)
        }
    }
    
    var deleteButton: some View {
        Button(action: workspaceViewModel.action, label: {
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
            Text(workspaceViewModel.workspace.accessCode)
        }.frame(width: 88, height: 29)
    }
    
    var body: some View {
        ZStack {
            NavigationLink(destination: ProjectView().environmentObject(projectViewModel), label: {
                RoundedRectangle(cornerRadius: 10).foregroundColor(workspaceViewModel.isHovered ? Color.theme.grayBackground : .white)
                    .onHover(perform: { _ in
                        workspaceViewModel.isHovered.toggle()
                    })
                    .frame(width: 488, height: 283.96)
                    .shadow(radius: 10, x: 0, y: 4)
            })
            .simultaneousGesture(TapGesture().onEnded {
                workspaceViewModel.selectWorkspace(workspaceId: workspaceViewModel.workspace.id)
                projectViewModel.selectedProject = workspaceViewModel.workspace
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
