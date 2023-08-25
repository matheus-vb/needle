//
//  ProjectButton.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//


import SwiftUI

struct ProjectButton: View {
    @EnvironmentObject var projectViewModel: ProjectViewModel<AuthenticationManager, TaskDataService, WorkspaceDataService>
    let project: Workspace
    @State var onHover = false

    var body: some View {
        Button(action: {
            projectViewModel.getRoleInWorkspace(workspaceId: project.id)
            projectViewModel.getWorkspaceTasks(workspaceId: project.id)
            projectViewModel.getWorkspaceMembers(workspaceId: project.id)
            
            Task {
                withAnimation {
                    projectViewModel.triggerLoading = true
                }
                try? await Task.sleep(nanoseconds: 600_000_000)
                projectViewModel.selectedWorkspace = project
                withAnimation {
                    projectViewModel.triggerLoading = false
                }
            }
        }, label:{
            HStack{
                Text("\(project.name)")
                .font(
                Font.custom("SF Pro", size: 12)
                .weight(.semibold)
                )
                .foregroundColor(.black)
            }
//            .frame(height: 48, alignment: .center)
            .frame(maxWidth: .infinity, idealHeight: 48)
            .background(projectViewModel.selectedWorkspace.accessCode == project.accessCode ? (onHover ? Color.theme.greenSecondary : Color.theme.greenMain) : (onHover ? Color.white : Color.theme.grayBackground))
//            .background(onHover ? Color.theme.greenSecondary : Color.theme.greenMain)
            .cornerRadius(6)
            .overlay(
              RoundedRectangle(cornerRadius: 6)
                .inset(by: 0.5)
                .stroke(Color.theme.blackMain, style: StrokeStyle(lineWidth: 1))
            )
        })
        .buttonStyle(.plain)
        .padding(.horizontal, 10)
        .onHover { Bool in
            onHover = Bool
        }
    }
}
