//
//  KanbanColumnTitleView.swift
//  NeedleApp
//
//  Created by Jpsmor on 04/08/23.
//

import SwiftUI

extension ContentView {
    @ViewBuilder
    func KanbanColumnTitleView(rowName: String, color: Color) -> some View {
        
        HStack{
            Circle()
                .frame(width: 10)
                .foregroundColor(color)
                .cornerRadius(5)
            Spacer()
                .frame(width: 8)
            Text(rowName)
                .font(
                    Font.custom("SF Pro", size: 18)
                        .weight(.medium)
                )
                .foregroundColor(.black)
            Spacer()
            Button {
                trashButtonKanban(rowName: rowName)
            } label: {
                Image(systemName: "trash")
            }
            .buttonStyle(PlainButtonStyle())
            
        }
        .frame(width: 264, height: 32)
        .cornerRadius(5)
        
    }
    
    func trashButtonKanban(rowName: String) {
        switch rowName {
        case "A fazer":
            self.tasks.removeAll { task in
                task.status == TaskStatus.TODO.rawValue
            }
        case "Fazendo":
            self.tasks.removeAll { task in
                task.status == TaskStatus.IN_PROGRESS.rawValue
            }
        case "Feito":
            self.tasks.removeAll { task in
                task.status == TaskStatus.DONE.rawValue
            }
        case "Em revisão":
            self.tasks.removeAll { task in
                task.status ==  TaskStatus.PENDING.rawValue
            }
        default:
            return
        }
    }
}
