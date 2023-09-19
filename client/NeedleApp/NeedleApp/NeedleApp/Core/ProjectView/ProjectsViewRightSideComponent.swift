//
//  ProjectsViewRightSide.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//

import SwiftUI

extension ProjectView {
    var ProjectViewRightSideComponent: some View {
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
}
