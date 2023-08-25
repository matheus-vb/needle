//
//  TaskCardView.swift
//  NeedleApp
//
//  Created by Jpsmor on 04/08/23.
//

import SwiftUI
import Firebase

extension KanbanView {
    @ViewBuilder
    func TaskCardView(task: TaskModel) -> some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 8) {
                HStack{
                    Text("Prazo: \(HandleDate.handleDate(date: task.endDate))")
                        .font(Font.custom("SF Pro", size: 12))
                        .foregroundColor(Color.theme.grayPressed)
                    Spacer()
                    Image(systemName: "flag.fill")
                        .font(Font.custom("SF Pro", size: 12))
                        .foregroundColor(getPriorityFlagColor(priority: task.taskPriority))
                }
                Text(task.user?.name ?? "Sem nome")
                    .font(Font.custom("SF Pro", size: 12))
                    .foregroundColor(Color.theme.blackMain)
                Text(task.title)
                    .font(Font.custom("SF Pro", size: 14))
                    .foregroundColor(Color.theme.blackMain)
            }
            Spacer()
                .frame(height: 16)
            HStack {
                KanbanTagView(taskType: task.type)
                Spacer()
                Button {
                    kanbanViewModel.selectedTask = task
                    kanbanViewModel.isArchiving.toggle()
                } label: {
                    Image(systemName: "archivebox")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .buttonStyle(PlainButtonStyle())
                .modifier(Clickable())
                
            }
            
        }
        .padding(16)
        .frame(minWidth: 128)
        .modifier(TaskCardBackground())
        .cornerRadius(6)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .inset(by: 0.5)
                .stroke(.black, lineWidth: 1)
        )
        .draggable(task.id)
        .dropDestination(for: String.self) { items, location in
            kanbanViewModel.currentlyDragging = items.first
            
            if kanbanViewModel.localTasks.first(where: { $0.id == kanbanViewModel.currentlyDragging }) != nil {
                withAnimation(.easeIn) {
                    swapItem(droppingTask: task, currentlyDragging: kanbanViewModel.currentlyDragging ?? "")
                }
            }
            
            Analytics.logEvent(K.movedTask.rawValue, parameters: nil)
            
            kanbanViewModel.currentlyDragging = ""
            
            return false
        } isTargeted: { status in
            if status {
                kanbanViewModel.somethingBeingDragged = true
                kanbanViewModel.currentlyTarget = task.id
            } else {
                kanbanViewModel.somethingBeingDragged = false
                kanbanViewModel.currentlyTarget = task.id
            }
        }
        .simultaneousGesture(LongPressGesture().onChanged({ _ in
            kanbanViewModel.currentlyDragging = task.id
        }))
        .simultaneousGesture(TapGesture(count: 2).onEnded({ _ in
            kanbanViewModel.selectedTask = task
            kanbanViewModel.isEditing.toggle()
        }))
        //        .onTapGesture(count: 2) {
        //            kanbanViewModel.selectedTask = task
        //            kanbanViewModel.isEditing.toggle()
        //        }
    }
    
    
}

