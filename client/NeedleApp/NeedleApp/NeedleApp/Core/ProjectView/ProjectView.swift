//
//  ProjectView.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//

import SwiftUI

struct ProjectView: View {
    
    @EnvironmentObject var projectViewModel: ProjectViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State var isAnimating = false
    
    @State var initalLoading = true
    
    var body: some View {
        main
    }
    
    var loading: some View {
        ZStack {
            Image("icon-bg")
                .offset(x: 200, y: 40)
                .blur(radius: 8)
                .frame(width: 400, height: 200)
            Circle()
                .trim(from: 0, to: 0.8)
                .stroke(Color.theme.greenMain, lineWidth: 4)
                .frame(width: 50, height: 50)
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .onAppear() {
                    withAnimation (.linear(duration: 1).repeatForever(autoreverses: false)) {
                        self.isAnimating.toggle()
                    }
                }
        }
    }
    
    var main: some View {
        GeometryReader{geometry in
            NavigationSplitView(sidebar: {
                Button("BACK") {
                    dismiss()
                }
                ProjectLeftSideComponent()
                    .padding(.top, 62)
                    .background(Color.theme.grayBackground)
                    .environmentObject(projectViewModel)
            }, detail: {
                ZStack {
                    if projectViewModel.triggerLoading || initalLoading {
                        loading
                            .onAppear {
                                Task {
                                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                                    withAnimation {
                                        initalLoading = false
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
            .popover(isPresented: $projectViewModel.showEditTaskPopUP, content: {
                EditTaskPopUP(geometry: geometry)
                    .environmentObject(EditTaskViewModel(data: projectViewModel.selectedTask!, workspaceID: projectViewModel.selectedProject.id))
                    .environmentObject(projectViewModel)
            })
            .popover(isPresented: $projectViewModel.showPopUp, content: {
                CreateTaskPopUp(createTaskViewModel: CreateTaskViewModel(members: projectViewModel.workspaceMembers[projectViewModel.selectedProject.id] ?? []), geometry: geometry)
                    .environmentObject(projectViewModel)
            })
            .onAppear{
                if projectViewModel.selectedProject.accessCode == ""{
                    projectViewModel.selectedProject = projectViewModel.projects[0]
                }
            }
        }
    }
}

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView()
    }
}
