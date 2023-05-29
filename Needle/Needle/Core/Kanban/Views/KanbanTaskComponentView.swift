//
//  KanbanTaskComponentView.swift
//  Needle
//
//  Created by gabrielfelipo on 26/05/23.
//

import SwiftUI

struct KanbanTaskComponentView: View {
    let TaskTitle: String
    let TaskTagType: String
    let columm: TaskColumn
    
    private var colorTaskColumn: Color {
        return columm == .inReviw ? .orange : .gray
    }
    
    var body: some View {
        VStack{
            Spacer().frame(height: 12)
            HStack{
                Spacer().frame(width: 20)
                Text(TaskTitle)
                    .foregroundColor(.black)
                Spacer()
            }
            Spacer()
            HStack{
                Spacer()
                TaskTagView(tagType: TaskTagType)
                Spacer().frame(width: 16)
            }
            Spacer().frame(height: 12)
        }.frame(width: 256, height: 135)
        .background(.white).cornerRadius(8)
        .shadow(color: colorTaskColumn,radius: 8)
    }
}

struct KanbanTaskComponentView_Previews: PreviewProvider {
    static var previews: some View {
        KanbanTaskComponentView(TaskTitle: "task 1", TaskTagType: "dev", columm: .inReviw)
    }
}
