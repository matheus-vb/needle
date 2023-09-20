//
//  ProjectView.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//

import SwiftUI

struct ProjectView: View {
    
    @ObservedObject var projectViewModel: ProjectViewModel<AuthenticationManager, TaskDataService, WorkspaceDataService>
    @State var triggerLoading: Bool = true
    @State var initalLoading: Bool = true
    init(selectedWorkspace: Workspace) {
        self.projectViewModel = ProjectViewModel(selectedWorkspace: selectedWorkspace, manager: AuthenticationManager.shared, taskDS: TaskDataService.shared, workspaceDS: WorkspaceDataService.shared)
        self.triggerLoading = true
        self.initalLoading = true
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
            .frame(width: .infinity, height: .infinity)
            main
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
        GeometryReader{geometry in
            NavigationSplitView(sidebar: {
                ProjectLeftSideComponent(triggerLoading: $triggerLoading)
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
                        ProjectsViewRightSideComponent()
//                            .background(Color.theme.grayBackground)
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
                    //.frame(height: geometry.size.width*0.33)
            })
            .onAppear{
                if projectViewModel.selectedWorkspace.accessCode == ""{
                    projectViewModel.selectedWorkspace = projectViewModel.projects[0]
                }
            }
        }
    }
}
