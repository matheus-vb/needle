//
//  TaskCardView.swift
//  NeedleApp
//
//  Created by Jpsmor on 04/08/23.
//

import SwiftUI

extension ContentView {
    
    @ViewBuilder
    func TaskCardView(task: TaskModel) -> some View {
        
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 8) {
                HStack{
                    Text("Prazo: \(task.endDate)")
                        .font(Font.custom("SF Pro", size: 12))
                        .foregroundColor(Color(red: 0.63, green: 0.63, blue: 0.63))
                    Spacer()
//                    Text("􀋊")
//                        .font(Font.custom("SF Pro", size: 12))
//                        .foregroundColor(Color(red: 0.94, green: 0.27, blue: 0.27))
//                    foi de base pois a taskmodel n tem prioridade
                }
                Text(task.userId ?? "Sem nome")
                    .font(Font.custom("SF Pro", size: 12))
                    .foregroundColor(.black)
                Text(task.title)
                    .font(Font.custom("SF Pro", size: 14))
                    .foregroundColor(.black)
            }
            Spacer()
                .frame(height: 16)
            ScrollView(.vertical) {
                Text(task.description)
                    .font(Font.custom("SF Pro", size: 12))
                    .foregroundColor(Color(red: 0.63, green: 0.63, blue: 0.63))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            KanbanTagView(taskType: task.type)
            Spacer()
                .frame(height: 10)
        }
        .padding(16)
        .frame(width: 256, height: 244, alignment: .topLeading)
        .background(.white)
        .cornerRadius(6)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .inset(by: 0.5)
                .stroke(.black, lineWidth: 1)
        )
        .draggable(task.id ?? "")
        .dropDestination(for: String.self) { items, location in
//            print(items)
//            print(task.id)
//            print(location)
            currentlyDragging = items.first
            //                print("drop destination!")
            withAnimation(.easeIn) {
                swapItem(droppingTask: task, currentlyDragging: currentlyDragging ?? "")
            }
            return false
        } isTargeted: { status in
        }
        
        
    }
    
    
    
    func convertDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = .autoupdatingCurrent
        return dateFormatter.string(from: date)
    }
    
}

