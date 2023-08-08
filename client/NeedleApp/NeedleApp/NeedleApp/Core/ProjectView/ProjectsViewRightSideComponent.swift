//
//  ProjectsViewRightSide.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//

import SwiftUI

struct ProjectsViewRightSideComponent: View {
    @EnvironmentObject var projectViewModel: ProjectViewModel
    var body: some View {
        VStack{
            topContainer
                .padding([.top], 64)
                .padding([.leading, .trailing], 64)
            Spacer()
            if projectViewModel.selectedTab == .Kanban{
                KanbanView()
                    .environmentObject(projectViewModel)
                    .environmentObject(KanbanViewModel(localTasks: projectViewModel.tasks[projectViewModel.selectedProject.id] ?? []))
            }else if projectViewModel.selectedTab == .Documentation{
                SearchDocuments()
            }
        }
    }
}
