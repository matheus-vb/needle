//
//  KanbanTaskComponentView.swift
//  Needle
//
//  Created by gabrielfelipo on 26/05/23.
//

import SwiftUI

struct KanbanTaskComponentView: View {
    var body: some View {
        VStack{
            Spacer().frame(height: 8)
            HStack{
                Spacer().frame(width: 16)
                Text("Task")
                    .foregroundColor(.black)
                Spacer()
            }
            Spacer()
            HStack{
                Spacer()
                TaskTagView(tagType: .dev)
                Spacer().frame(width: 16)
            }
            Spacer().frame(height: 12)
        }
        .background(.white).cornerRadius(8)
        .shadow(color: .orange, radius: 8)
    }
}

struct KanbanTaskComponentView_Previews: PreviewProvider {
    static var previews: some View {
        KanbanTaskComponentView()
    }
}
