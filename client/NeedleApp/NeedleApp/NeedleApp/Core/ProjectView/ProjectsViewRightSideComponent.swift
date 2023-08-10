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
            HStack {
                statusTitleLabel(rowName: "A fazer", color: Color.theme.redMain)
                statusTitleLabel(rowName: "Fazendo", color: Color.theme.blueKanban)
                statusTitleLabel(rowName: "Em revisão", color: Color.theme.orangeKanban)
                statusTitleLabel(rowName: "Feito", color: Color.theme.greenKanban)
            }
            .padding(.leading, 64)
            .padding(.trailing, 64)
            .padding(.top, 24)
            .offset(x: 12)
            
            if projectViewModel.selectedTab == .Kanban{
                KanbanView()
                    .environmentObject(projectViewModel)
                    .environmentObject(KanbanViewModel(localTasks: projectViewModel.tasks[projectViewModel.selectedProject.id] ?? []))
            }else if projectViewModel.selectedTab == .Documentation{
                SearchDocuments()
                    .environmentObject(SearchDocumentsViewModel(tasks: projectViewModel.tasks[projectViewModel.selectedProject.id] ?? [], workspaceId: projectViewModel.selectedProject.id))
                    .environmentObject(projectViewModel)
            }
        }
    }
}
