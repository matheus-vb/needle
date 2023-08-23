//
//  KanbanView.swift
//  NeedleApp
//
//  Created by Jpsmor on 04/08/23.
//

import SwiftUI

struct KanbanView: View {
    @ObservedObject var kanbanViewModel: KanbanViewModel
    
    init(tasks: [TaskModel], role: Role, selectedColumn: Binding<TaskStatus>, showPopUp: Binding<Bool>, showCard: Binding<Bool>, selectedWorkspace: Workspace, selectedTask: Binding<TaskModel?>, isEditing: Binding<Bool>) {
        
        self.kanbanViewModel = KanbanViewModel(
            localTasks: tasks,
            role: role,
            selectedColumn: selectedColumn,
            showPopUp: showPopUp,
            showCard: showCard,
            selectedWorkspace: selectedWorkspace,
            selectedTask: selectedTask,
            isEditing: isEditing
        )
    }
    
    var body: some View {
        ZStack {
            Image("icon-bg")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 2000, alignment: .bottomTrailing)
            HStack(alignment: .center) {
                Spacer()
                HStack(spacing: 30) {
                    ForEach ([TaskStatus.TODO, TaskStatus.IN_PROGRESS, TaskStatus.PENDING, TaskStatus.DONE], id: \.self) { status in
                        KanbanColumnView(status: status)
                    }
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 32, leading: 64, bottom: 0, trailing: 64))
            .onAppear {
                kanbanViewModel.presentCard()
            }
        }.sheet(isPresented: $kanbanViewModel.isArchiving, content: {
            SheetView(type: .archiveTask)
        })
    }
    
}


