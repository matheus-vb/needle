//
//  KanbanTagView.swift
//  NeedleApp
//
//  Created by Jpsmor on 04/08/23.
//

import SwiftUI

struct KanbanTagView: View {
    
    let taskType: TaskType
    
    var body: some View {
        Text(tagName(tagName: taskType))
            .frame(height: 28)
            .font(Font.custom("SF Pro", size: 12))
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 0)
            .background(tagColor(tagName: taskType))
            .cornerRadius(6)
    }
    
    func tagColor(tagName: TaskType) -> Color {
        switch tagName {
        case TaskType.DEV:
            return Color.theme.blueMain
        case TaskType.DESIGN:
            return Color.theme.orangeMain
        default:
            return Color.theme.redMain
        }
    }
    
    func tagName(tagName: TaskType) -> String {
        switch tagName {
        case TaskType.DEV:
            return "Dev"
        case TaskType.DESIGN:
            return "Design"
        default:
            return "Outros"
        }
    }
}
