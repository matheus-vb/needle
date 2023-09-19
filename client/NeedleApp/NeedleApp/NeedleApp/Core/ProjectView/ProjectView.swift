//
//  ProjectView.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//

import SwiftUI

struct ProjectView: View {
    
    @ObservedObject var projectViewModel: ProjectViewModel<AuthenticationManager, TaskDataService, WorkspaceDataService>
    @Environment(\.dismiss) var dismiss
    @State var triggerLoading: Bool = true
    @State var initalLoading: Bool = true
    
    init(selectedWorkspace: Workspace) {
        self.projectViewModel = ProjectViewModel(selectedTab: .Kanban, selectedWorkspace: selectedWorkspace, manager: AuthenticationManager.shared, taskDS: TaskDataService.shared, workspaceDS: WorkspaceDataService.shared)
        triggerLoading = true
        initalLoading = true
    }
    
    var body: some View {
        ZStack {
            main
            VStack {
                Spacer()
            }
            .sheet(isPresented: $projectViewModel.showShareCode, content: {
                SheetView(accessCode: projectViewModel.getCode(), type: .shareCode)
            })
            .offset(y: projectViewModel.showCard ? 0 : -500)
        }
    }
    
    var loading: some View {
        ZStack {
            Image("icon-bg")
                .offset(x: 200, y: 40)
                .blur(radius: 8)
                .frame(width: 400, height: 200)
            Circle()
                .trim(from: 0, to: 0.8)
                .stroke(Color.theme.blackMain, lineWidth: 4)
                .frame(width: 50, height: 50)
                .rotationEffect(.degrees(projectViewModel.isAnimating ? 360 : 0))
                .onAppear() {
                    withAnimation (.linear(duration: 1).repeatForever(autoreverses: false)) {
                        projectViewModel.isAnimating.toggle()
                    }
                }
        }
    }
    
    var ProjectsViewRightSideComponent: some View {
        VStack{
            topContainer
                .padding([.top], 64)
                .padding([.leading, .trailing], 64)
            HStack {
                statusTitleLabel(rowName: NSLocalizedString("A fazer", comment: ""), color: Color.theme.redMain)
                statusTitleLabel(rowName: NSLocalizedString("Fazendo", comment: ""), color: Color.theme.blueKanban)
                statusTitleLabel(rowName: NSLocalizedString("Em revisão", comment: ""), color: Color.theme.orangeKanban)
                statusTitleLabel(rowName: NSLocalizedString("Feito", comment: ""), color: Color.theme.greenKanban)
            }
            .padding(.leading, 64)
            .padding(.trailing, 64)
            .padding(.top, 24)
            .offset(x: 12)
            
            if projectViewModel.selectedTab == .Kanban{
                KanbanView(tasks: projectViewModel.tasks[projectViewModel.selectedWorkspace.id] ?? [], role: projectViewModel.roles[projectViewModel.selectedWorkspace.id] ?? .DEVELOPER, selectedColumn: $projectViewModel.selectedColumnStatus, showPopUp: $projectViewModel.showPopUp, showCard: $projectViewModel.showCard, selectedWorkspace: projectViewModel.selectedWorkspace, selectedTask: $projectViewModel.selectedTask, isEditing: $projectViewModel.showEditTaskPopUP)
            }else if projectViewModel.selectedTab == .Documentation{
                SearchDocuments(tasks: projectViewModel.tasks[projectViewModel.selectedWorkspace.id] ?? [], workspaceId: projectViewModel.selectedWorkspace.id, selectedTask: $projectViewModel.selectedTask, isEditing: $projectViewModel.showEditTaskPopUP)
            }
        }
    }
        
    
    var main: some View {
        GeometryReader{geometry in
            NavigationSplitView(sidebar: {
                ProjectLeftSideComponent
                    .padding(.top, 62)
                    .background(Color.theme.grayBackground)
                    .environmentObject(projectViewModel)
            }, detail: {
                ZStack {
                    if triggerLoading || initalLoading {
                        loading
                            .onAppear {
                                Task {
                                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                                    withAnimation {
                                        initalLoading = false
                                        triggerLoading = false
                                    }
                                }
                            }
                    } else {
                        ProjectsViewRightSideComponent
                            .background(Color.theme.grayBackground)
                            .environmentObject(projectViewModel)
                    }
                }
            })
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $projectViewModel.showEditTaskPopUP, content: {
                EditTaskPopUP(data: projectViewModel.selectedTask!, workspaceID: projectViewModel.selectedWorkspace.id, members: projectViewModel.workspaceMembers[projectViewModel.selectedWorkspace.id] ?? [], isEditing: $projectViewModel.showEditTaskPopUP, geometry: geometry)
            })
            .sheet(isPresented: $projectViewModel.showPopUp, content: {
                CreateTaskPopUp(geometry: geometry, members: projectViewModel.workspaceMembers[projectViewModel.selectedWorkspace.id] ?? [], showPopUp: $projectViewModel.showPopUp, selectedWorkspace: projectViewModel.selectedWorkspace, selectedStatus: projectViewModel.selectedColumnStatus)
            })
            .onAppear{
                projectViewModel.workspaceMembers[projectViewModel.selectedWorkspace.id]?.append(User(id: "", name: "---", email: "", workspaces: []))
                if projectViewModel.selectedWorkspace.accessCode == ""{
                    projectViewModel.selectedWorkspace = projectViewModel.projects[0]
                }
            }
    
        }
    }
}
