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
            main
            VStack {
                AlertBoxView()
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(.black, lineWidth: 2))
                    .padding(.top, 10)
                Spacer()
            }
            .sheet(isPresented: $projectViewModel.showShareCode, content: {
                SheetView(accessCode: projectViewModel.getCode(), type: .shareCode)
            })
            .offset(y: projectViewModel.showCard ? 0 : -500)
            .animation(.easeInOut, value: projectViewModel.showCard)
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
