//
//  ProjectButton.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//

import SwiftUI

struct ProjectButton: View {
    @EnvironmentObject var projectViewModel: ProjectViewModel

    @State var hovering = false
    let project: Workspace
    var body: some View {
        Button(action: {
            AuthenticationManager.shared.getRoleInWorkspace(userId: AuthenticationManager.shared.user!.id, workspaceId: project.id)
            TaskDataService.shared.getWorkspaceTasks(userId: AuthenticationManager.shared.user!.id, workspaceId: project.id)
            WorkspaceDataService.shared.getWorkspaceMembers(workspaceId: project.id)
            Task {
                withAnimation {
                    projectViewModel.triggerLoading = true
                }
                try? await Task.sleep(nanoseconds: 600_000_000)
                projectViewModel.selectedProject = project
                withAnimation {
                    projectViewModel.triggerLoading = false
                }
            }
        }, label: {
            Text("\(project.name)")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.black)
                .padding([.leading, .trailing], 64)
                .padding([.top, .bottom], 17)
                .background(projectViewModel.selectedProject.accessCode == project.accessCode ? Color.theme.greenMain : hovering ? Color.theme.greenSecondary : Color.theme.grayBackground)})

        .onHover(perform: { _ in
            hovering.toggle()
        })
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(style: StrokeStyle(lineWidth: 1))
                .foregroundColor(.black)
        )
        .buttonStyle(.plain)
    }
}
