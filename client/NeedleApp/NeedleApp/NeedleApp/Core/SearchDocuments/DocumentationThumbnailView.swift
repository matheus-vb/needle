//
//  DocumentationThumbnailView.swift
//  NeedleApp
//
//  Created by aaav on 04/10/23.
//

import SwiftUI

struct DocumentationThumbnailView: View {
    var done : String = "checkmark.circle.fill"
    var rejected : String = "arrow.counterclockwise.circle.fill"
    var pending : String = "clock.fill"
    
    var task: TaskModel
    var showDate : Bool

    var body: some View {
        
        VStack{
            
            ZStack{
                VStack{
                    HStack{
                        Text(task.document?.textString ?? NSLocalizedString("SEM DOCUMENTAÇÃO", comment: ""))
                            .font(.custom("SF Pro", size: 8)
                                .weight(.regular))
                            .foregroundColor(Color.theme.blackMain)
                            .padding(8)
                            .padding([.leading, .top], 10)
                    Spacer()
                    }
                Spacer()
                }
                HStack{
                    Spacer()
                    VStack{
                        Image(systemName: task.status == TaskStatus.DONE ? done : (task.isRejected ? rejected : pending))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(task.status == TaskStatus.DONE ? .green : (task.isRejected ? .orange : .yellow))
                            .background(.white)
                            .clipShape(Circle())
                            .padding(8)
                        Spacer()
                    }
                }
            }
            
            Spacer()
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.custom("SF Pro", size: 12))
                    .foregroundColor(.white)
                Text(showDate ? HandleDate.formatDateWithTime(dateInput: task.updated_at) : task.user?.name ?? NSLocalizedString("Sem responsável", comment: ""))
                    .foregroundColor(.white)
                        .font(.custom("SF Pro", size: 10))
            }
            .padding(.leading, 16)
            .frame(width: 286,height: 35, alignment: .leading)
            .background(Color.theme.grayHover)
            
            
        }
        .background(.white)
        .frame(width: 286, height: 179)
        .cornerRadius(6)
        
    }
}

//struct DocumentationThumbnailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DocumentationThumbnailView(taskTitle: "Some Task", taskOwner: "André Valença", taskContent: "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book. It usually begins with:", isRejected: true, status: TaskStatus.DONE)
//    }
//}
