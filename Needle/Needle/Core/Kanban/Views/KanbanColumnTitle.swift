//
//  KanbanColumnTitle.swift
//  Needle
//
//  Created by gabrielfelipo on 29/05/23.
//

import SwiftUI

struct KanbanColumnTitle: View {
    let title: TaskColumn
    
    private var colorTaskColumn: Color {
        let cor: Color = (title == .toDo) ? .gray :
        (title == .inProgress) ? .blue :
              (title == .inReviw) ? .orange :
              .green;
        return cor
    }
    
    var body: some View {
        ZStack{
            Rectangle().foregroundColor(colorTaskColumn)
                .frame(height: 51)
                .opacity(0.2)
                .cornerRadius(8)
            HStack{
                Rectangle().foregroundColor(colorTaskColumn)
                    .frame(width: 19, height: 51)
                    .opacity(0.6)
                    .cornerRadius(4)
                    
                Text(title.rawValue).foregroundColor(.black)
                Spacer()
            }
        }.padding(12)
    }
}

struct KanbanColumnTitle_Previews: PreviewProvider {
    static var previews: some View {
        KanbanColumnTitle(title: .inReviw)
    }
}
