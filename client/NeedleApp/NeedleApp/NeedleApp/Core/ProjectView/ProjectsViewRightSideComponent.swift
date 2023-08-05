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
                KanbanView(tasks: projectViewModel.tasks[projectViewModel.selectedProject.id] ?? [])
                    .environmentObject(projectViewModel)
            }else if projectViewModel.selectedTab == .Documentation{
                DummyDocumentationView()
                    .foregroundColor(.black)
                    .font(.system(size: 60))
            }
        }
    }
}
