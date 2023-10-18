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
        VStack() {
            VStack(alignment: .leading, spacing: 0) {
                HStack{
                    Text("\(NSLocalizedString("Prazo", comment: "")): \(HandleDate.handleDate(date: task.endDate))")
                        .font(Font.custom("SF Pro", size: 10))
                        .foregroundColor(Color.theme.grayText)
                    
                    Spacer()
                    
                    Text(task.taskPriority.displayName)
                        .font(Font.custom("SF Pro", size: 10))
                        .foregroundColor(Color.theme.grayText)
                    
                    Image(systemName: "flag.fill")
                        .font(Font.custom("SF Pro", size: 12))
                        .foregroundColor(kanbanViewModel.getPriorityFlagColor(priority: task.taskPriority))
                }
                
                Spacer()
                    .frame(height: 6)
                
                Text(task.user?.name ?? NSLocalizedString("Sem responsável.", comment: ""))
                    .padding(4)
                    .font(Font.custom("SF Pro", size: 8))
                    .foregroundColor(Color.theme.blackMain)
                    .background(Color.theme.greenTags)
                    .clipShape(RoundedRectangle(cornerRadius: 2))
                
                Spacer()
                    .frame(height: 8)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(task.title)
                        .font(
                            Font.custom("SF Pro", size: 12)
                                .weight(.medium)
                        )
                        .foregroundColor(Color.theme.blackMain)
                        .lineLimit(1)
                    Text(task.description)
                        .font(Font.custom("SF Pro", size: 8))
                        .foregroundColor(Color.theme.grayText)
                        .lineLimit(2)
                }
                
                Spacer()
                    .frame(height: 10)
                
                HStack(alignment: .center) {
                    if task.document != nil {
                        ZStack(alignment: .center) {
                            Circle()
                                .foregroundStyle(Color.theme.greenTags)
                                .frame(width: 24)
                            Image("temdoc")
                                .font(Font.custom("SF Pro", size: 10))
                                .foregroundColor(.white)
                        }
                    }
                    KanbanTagView(taskType: task.type)
                    
                    Spacer()
                    
                    Button {
                        if disableTap == false {
                            kanbanViewModel.selectedTask = task
                            TaskDataService.shared.updateTaskVisibility(taskId: kanbanViewModel.selectedTask!.id, isVisible: kanbanViewModel.selectedTask!.isVisible, userId: kanbanViewModel.userID, workspaceId: kanbanViewModel.selectedWorkspace.id)
                        }
                    } label: {
                        if task.isVisible {
                            Image(systemName: "eye")
                                .font(Font.custom("SF Pro", size: 12))
                                .foregroundStyle(Color.theme.grayText)
                        } else {
                            Image(systemName: "eye.slash")
                                .font(Font.custom("SF Pro", size: 12))
                                .foregroundStyle(Color.theme.grayText)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .modifier(Clickable())
                    
                    Button {
                        if disableTap == false {
                            kanbanViewModel.selectedTask = task
                            kanbanViewModel.isDeleting.toggle()
                        }
                    } label: {
                        Image(systemName: "trash")
                            .font(Font.custom("SF Pro", size: 12))
                            .foregroundStyle(Color.theme.grayText)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .modifier(Clickable())
                }
            }
        }
        .padding(8)
        .frame(minWidth: 125)
        .frame(height: 140, alignment: .leading)
        .modifier(TaskCardBackground())
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .opacity(task.isVisible ? 1 : 0.5)
        .draggable(task.id)
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
    
    @ViewBuilder
    func PositionPreview(backgroundColor: Color) -> some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(minWidth: 125)
            .frame(height: 140)
            .background(backgroundColor.opacity(0.2))
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .inset(by: 0.5)
                    .stroke(.black, style: StrokeStyle(lineWidth: 1, dash: [12, 12]))
            )
            .padding(.horizontal, 8)
    }
}

