//
//  ProjectButton.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//


import SwiftUI
import Firebase

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
            Analytics.logEvent(K.changeWorkspace.rawValue, parameters: nil)
        }, label:{
            VStack (alignment: .leading){
                Text("\(project.name)")
                    .font(Font.custom("SF Pro", size: 12).weight(.regular))
                    .foregroundColor(Color.theme.blackMain)
                    .padding(.bottom, 5)
                Text("Você tem tasks")
                    .font(Font.custom("SF Pro", size: 10).weight(.regular))
                    .foregroundColor(Color.theme.grayPressed)
            }
            .frame(height: 56)
            .padding(.vertical, 5)
            .padding(.leading, 5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(projectViewModel.selectedWorkspace.accessCode == project.accessCode ? Color.theme.greenSecondary.blur(radius: 15, opaque: false)
 : (onHover ? Color.white.blur(radius: 15, opaque: false) : Color.theme.grayBackground.blur(radius: 15, opaque: false)))
//            .background(onHover ? Color.theme.greenSecondary : Color.theme.greenMain)
            .cornerRadius(6)
//            .overlay(
//              RoundedRectangle(cornerRadius: 6)
//                .inset(by: 0.5)
//                .stroke(Color.theme.blackMain, style: StrokeStyle(lineWidth: 1))
//            )
        })
        .buttonStyle(.plain)
//        .padding(.horizontal, 10)
        .onHover { Bool in
            onHover = Bool
        }
    }
}
