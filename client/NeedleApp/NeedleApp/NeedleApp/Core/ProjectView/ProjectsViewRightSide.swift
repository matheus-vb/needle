//
//  ProjectsViewRightSide.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//

import SwiftUI

extension ProjectView {
    var ProjectsViewRightSide: some View {
        VStack{
            topContainer
                .padding([.top], 64)
                .padding([.leading, .trailing], 64)
            
            if projectViewModel.navigateToDocument {
                DocumentationView()

            }
            else {
                if selectedTab == .Kanban {
                    KanbanView(tasks: projectViewModel.tasks[projectViewModel.selectedWorkspace.id] ?? [], role: projectViewModel.roles[projectViewModel.selectedWorkspace.id] ?? .DEVELOPER, selectedColumn: $projectViewModel.selectedColumnStatus, showPopUp: $projectViewModel.showPopUp, showCard: $projectViewModel.showCard, selectedWorkspace: projectViewModel.selectedWorkspace, selectedTask: $projectViewModel.selectedTask, isEditing: $projectViewModel.showEditTaskPopUP)
                }else if selectedTab == .Documentation{
                    SearchDocuments(tasks: projectViewModel.tasks[projectViewModel.selectedWorkspace.id] ?? [], workspaceId: projectViewModel.selectedWorkspace.id, selectedTask: $projectViewModel.selectedTask, isEditing: $projectViewModel.showEditTaskPopUP)
                } else if selectedTab == .Information{
                    InformationPageView(tasks: projectViewModel.tasks[projectViewModel.selectedWorkspace.id] ?? [], workspaceMembers: projectViewModel.workspaceMembers[projectViewModel.selectedWorkspace.id], workspace: projectViewModel.selectedWorkspace)
                }
            }
        }
    }
}
