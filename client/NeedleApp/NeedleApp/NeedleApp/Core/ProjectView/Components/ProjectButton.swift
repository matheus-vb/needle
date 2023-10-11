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
    @Binding var triggerLoading: Bool
    
    init(project: Workspace, triggerLoading: Binding<Bool>){
        self._triggerLoading = triggerLoading
        self.project = project
    }

    var body: some View {
        Button(action: {
            projectViewModel.getRoleInWorkspace(workspaceId: project.id)
            projectViewModel.getWorkspaceTasks(workspaceId: project.id)
            projectViewModel.getWorkspaceMembers(workspaceId: project.id)
            Task {
                withAnimation {
                    triggerLoading = true
                }
                try? await Task.sleep(nanoseconds: 600_000_000)
                projectViewModel.selectedWorkspace = project
                print("newproject: \(projectViewModel.selectedWorkspace.name)")
                withAnimation {
                    triggerLoading = false
                }
            }
            Analytics.logEvent(K.changeWorkspace.rawValue, parameters: nil)
        }, label:{
            VStack (alignment: .leading){
                Text("\(project.name)")
                    .font(Font.custom("SF Pro", size: 15).weight(.regular))
                    .foregroundColor(Color.theme.blackMain)
                    .padding(.bottom, 5)
                    .scaleEffect(onHover ? 1.0 : 0.95)
                    .animation(.spring(), value: onHover)
                Text("  \(project.users.count) \(project.users.count > 1 ? "membros" : "membro")")
                    .font(Font.custom("SF Pro", size: 10).weight(.regular))
                    .foregroundColor(Color.theme.grayPressed)
            }
            .frame(height: 56)
            .padding(.vertical, 5)
            .padding(.leading, 5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(projectViewModel.selectedWorkspace.accessCode == project.accessCode ? Color.theme.grayBackground.blur(radius: 15, opaque: false) : Color.white.blur(radius: 8, opaque: false))
            .cornerRadius(6)
        })
        .buttonStyle(.plain)
        .onHover { Bool in
            onHover = Bool
        }
    }
}
