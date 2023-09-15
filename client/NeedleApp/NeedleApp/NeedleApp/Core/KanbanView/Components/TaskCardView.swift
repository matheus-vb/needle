//
//  TaskCardView.swift
//  NeedleApp
//
//  Created by Jpsmor on 04/08/23.
//

import SwiftUI

extension KanbanView {
    @ViewBuilder
    func TaskCardView(task: TaskModel) -> some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 8) {
                HStack{
                    Text("\(NSLocalizedString("Prazo", comment: "")): \(HandleDate.handleDate(date: task.endDate))")
                        .font(Font.custom("SF Pro", size: 12))
                        .foregroundColor(Color.theme.grayPressed)
                    Spacer()
                    Image(systemName: "flag.fill")
                        .font(Font.custom("SF Pro", size: 12))
                        .foregroundColor(kanbanViewModel.getPriorityFlagColor(priority: task.taskPriority))
                }
                Text(task.user?.name ?? NSLocalizedString("Sem responsável.", comment: ""))
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
            self.disableTap = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.disableTap = false
            }
            if task.status == .DONE {
                if kanbanViewModel.role != Role.PRODUCT_MANAGER {
                    return false
                }
            }
            kanbanViewModel.currentlyDragging = items.first
            
            if kanbanViewModel.localTasks.first(where: { $0.id == kanbanViewModel.currentlyDragging }) != nil {
                withAnimation(.easeIn) {
                    kanbanViewModel.swapItem(droppingTask: task, currentlyDragging: kanbanViewModel.currentlyDragging ?? "")
                }
            }
            
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
        .onTapGesture {
            if disableTap == false {
                kanbanViewModel.selectedTask = task
                kanbanViewModel.isEditing.toggle()
            }
        }
        .onLongPressGesture(minimumDuration: 0.25) {
            kanbanViewModel.currentlyDragging = task.id
        }
    }
    
    
}

