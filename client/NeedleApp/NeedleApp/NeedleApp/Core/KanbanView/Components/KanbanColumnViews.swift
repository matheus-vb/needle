//
//  KanbanColumnViews.swift
//  NeedleApp
//
//  Created by Jpsmor on 23/08/23.
//

import SwiftUI
import Firebase

extension KanbanView {
    
    @ViewBuilder
    func KanbanColumnView(status : TaskStatus) -> some View {
        NavigationStack {
            VStack {
                addTaskButton(status: status)
                Spacer()
                    .frame(height: 24)
                ScrollView(.vertical) {
                    ForEach(kanbanViewModel.localTasks.filter {
                        $0.status == status
                    }) {task in
                        if kanbanViewModel.somethingBeingDragged && (kanbanViewModel.currentlyTarget ==  task.id) && ((kanbanViewModel.localTasks.firstIndex(where: {
                            $0.id == kanbanViewModel.currentlyDragging}) ?? 0) > kanbanViewModel.localTasks.firstIndex(where: {
                                $0.id == kanbanViewModel.currentlyTarget}) ?? 0) {
                            Rectangle()
                                .fill(Color.theme.greenKanban)
                                .frame(height: 6)
                                .cornerRadius(8)
                        }
                        TaskCardView(task: task)
                            .buttonStyle(.plain)
                        if kanbanViewModel.somethingBeingDragged && (kanbanViewModel.currentlyTarget ==  task.id) && ((kanbanViewModel.localTasks.firstIndex(where: {
                            $0.id == kanbanViewModel.currentlyDragging}) ?? 0) < kanbanViewModel.localTasks.firstIndex(where: {
                                $0.id == kanbanViewModel.currentlyTarget}) ?? 0) {
                            Rectangle()
                                .fill(Color.theme.greenKanban)
                                .frame(height: 6)
                                .cornerRadius(8)
                        }
                    }
                }
                .scrollIndicators(.never)
            }
        }
        .dropDestination(for: String.self) { items, location in
            kanbanViewModel.currentlyDragging = items.first
            
            withAnimation(.easeIn) {
                kanbanViewModel.addItem(currentlyDragging: kanbanViewModel.currentlyDragging ?? "", status: status)
            }
            Analytics.logEvent(K.movedTask.rawValue, parameters: nil)
            return false
        } isTargeted: { status in
        }
    }
    
}
