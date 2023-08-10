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
                    Text("Prazo: \(HandleDate.handleDate(date: task.endDate))")
                        .font(Font.custom("SF Pro", size: 12))
                        .foregroundColor(Color.theme.grayPressed)
                    Spacer()
                    Text("􀋊")
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
                    projectViewModel.selectedTask = task
                    isArchiving.toggle()
                } label: {
                    Image(systemName: "archivebox")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .buttonStyle(PlainButtonStyle())

            }

        }
        .padding(16)
        .frame(minWidth: 128)
        .background(.white)
        .cornerRadius(6)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .inset(by: 0.5)
                .stroke(.black, lineWidth: 1)
        )
        .draggable(task.id ?? "")
        .dropDestination(for: String.self) { items, location in
            currentlyDragging = items.first
            //                print("drop destination!")
            guard let temp = kanbanViewModel.localTasks.first(where: { $0.id == currentlyDragging }) else { return false }
            
            if temp.status != task.status {
                withAnimation {
                    addItem(currentlyDragging: currentlyDragging!, status: task.status)                    
                }
            } else {
                withAnimation(.easeIn) {
                    swapItem(droppingTask: task, currentlyDragging: currentlyDragging ?? "")
                }
            }
            
            return false
        } isTargeted: { status in
        }
        
        
    }


    func getPriorityFlagColor(priority: TaskPriority) -> Color {
        switch priority {
        case .HIGH:
            return Color.theme.redMain
        case .VERY_HIGH:
            return Color.theme.redMain
        case .MEDIUM:
            return Color.theme.orangeKanban
        case .LOW:
            return Color.theme.greenKanban
        }
    }
    
    
    
    func convertDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = .autoupdatingCurrent
        return dateFormatter.string(from: date)
    }
    
}

