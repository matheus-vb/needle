//
//  KanbanTagView.swift
//  NeedleApp
//
//  Created by Jpsmor on 04/08/23.
//

import SwiftUI

struct KanbanTagView: View {
    
    let taskType: String
    
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
    
    func tagColor(tagName: String) -> Color {
        switch tagName {
        case TaskType.DEV.rawValue:
            return Color(red: 0, green: 0.48, blue: 0.9)
        case TaskType.DESIGN.rawValue:
            return Color(red: 1, green: 0.68, blue: 0.38)
        default:
            return Color(red: 0.94, green: 0.27, blue: 0.27)
        }
    }
    
    func tagName(tagName: String) -> String {
        switch tagName {
        case TaskType.DEV.rawValue:
            return "Dev"
        case TaskType.DESIGN.rawValue:
            return "Design"
        default:
            return "Outros"
        }
    }
}

struct KanbanTagView_Previews: PreviewProvider {
    static var previews: some View {
        KanbanTagView(taskType: "Dev")
    }
}
