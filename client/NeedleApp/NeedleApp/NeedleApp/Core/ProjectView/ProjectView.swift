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
    @State var selectedTab: SelectedTab = .Kanban
    
    init(selectedWorkspace: Workspace) {
        self.projectViewModel = ProjectViewModel(selectedWorkspace: selectedWorkspace, manager: AuthenticationManager.shared, taskDS: TaskDataService.shared, workspaceDS: WorkspaceDataService.shared)
        triggerLoading = true
        initalLoading = true
    }
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                    .frame(maxWidth: .infinity)
                Image("Bg_Arte")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, alignment: .bottomTrailing)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            main
            VStack {
                Spacer()
            }
            .sheet(isPresented: $projectViewModel.showShareCode, content: {
                SheetView(accessCode: projectViewModel.getCode(), type: .shareCode)
            })
        }
    }
    
    var loading: some View {
        ZStack {
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
        
    
    var main: some View {
        GeometryReader { geometry in
            NavigationSplitView(sidebar: {
                ProjectSideBar
                    .padding(.top, 62)
                    .background(.white)
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
                        
                        ProjectsViewRightSide
                            .background(projectViewModel.navigateToDocument ? .white : Color.theme.grayBackground)
                            .environmentObject(projectViewModel)
                    }
                }
            })
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $projectViewModel.showEditTaskPopUP, content: {
                EditTaskPopUP(data: projectViewModel.selectedTask!, workspaceID: projectViewModel.selectedWorkspace.id, members: projectViewModel.workspaceMembers[projectViewModel.selectedWorkspace.id] ?? [], isEditing: $projectViewModel.showEditTaskPopUP, geometry: geometry, navigate: { projectViewModel.toggleNavigate() })
            })
            .sheet(isPresented: $projectViewModel.showPopUp, content: {
                CreateTaskPopUp(geometry: geometry, members: projectViewModel.workspaceMembers[projectViewModel.selectedWorkspace.id] ?? [], showPopUp: $projectViewModel.showPopUp, selectedWorkspace: projectViewModel.selectedWorkspace, selectedStatus: projectViewModel.selectedColumnStatus)
            })
            .sheet(isPresented: $projectViewModel.isDeleting, content: {
                SheetView(type: .deleteTaskKanban)
                    .foregroundColor(Color.theme.grayHover)
                    .background(.white)
                    .environmentObject(projectViewModel)
            })
            .sheet(isPresented: $projectViewModel.isArchiving, content: {
                SheetView(type: .archiveTaskKanban)
                    .foregroundColor(Color.theme.grayHover)
                    .background(.white)
                    .environmentObject(projectViewModel)
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
