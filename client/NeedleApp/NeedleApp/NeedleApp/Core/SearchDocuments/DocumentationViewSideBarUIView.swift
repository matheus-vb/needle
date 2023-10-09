//
//  DocumentationViewSideBarUIView.swift
//  NeedleApp
//
//  Created by aaav on 06/10/23.
//

import SwiftUI

struct DocumentationViewSideBarUIView: View {
    
    let tasks : [TaskModel]
    
    @State private var overText = -1
    @State private var overText2 = -1

    @ViewBuilder
    func feedbackListCell(index: Int) -> some View{
        HStack{
            Image(systemName: "arrow.counterclockwise.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundColor(.orange)
                .background(.white)
                .clipShape(Circle())
                .padding(8)
            
            Text(NSLocalizedString("\(index)", comment: ""))
                .foregroundColor(Color.theme.blackMain)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 99)
    }
    @ViewBuilder
    func pendingListCell(task: TaskModel) -> some View{
        
        VStack(alignment: .leading){
            HStack{
                Text(NSLocalizedString(task.title, comment: ""))
                    .font(.custom("SF Pro", size: 12))
                    .foregroundColor(Color.theme.blackMain)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: "flag.fill")
                    .foregroundColor(getPriorityFlagColor(priority: task.taskPriority))
            }
            HStack{
                Text(NSLocalizedString(task.user?.name ?? NSLocalizedString("Sem responsável", comment: ""), comment: ""))
                    .font(.custom("SF Pro", size: 10))
                    .foregroundColor(Color.theme.blackMain)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(tagName(tagName:task.type))
                    .frame(height: 18)
                    .font(Font.custom("SF Pro", size: 8))
                    .foregroundColor(.white)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 0)
                    .background(tagColor(tagName: task.type))
                    .cornerRadius(3)
            }
        }
        .padding(.vertical, 10)
        .padding(.trailing, 11)
        .frame(height: 40)
    }
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(NSLocalizedString("Feedbacks", comment: ""))
                    .font(.custom("SF Pro", size: 18)
                        .weight(.bold))
                    .foregroundColor(Color.theme.blackMain)
                Spacer()
                Text(NSLocalizedString("Limpar", comment: ""))
                    .font(.custom("SF Pro", size: 14))
                    .foregroundColor(Color.theme.blackMain)
                    .opacity(0.6)
            }
            .padding(20)
            
            Spacer()
            
            VStack(alignment: .leading){
                HStack{
                    ScrollView{
                        VStack(alignment: .leading){
                            ForEach(0..<tasks.count, id: \.self){ i in
                                feedbackListCell(index: i)
                                    .listRowInsets(EdgeInsets())
                                    .background(overText == i ? Color.theme.grayListHover : Color.clear)
                                    .onHover{hovering in
                                        if hovering{
                                            overText = i
                                        } else {
                                            overText = -1
                                        }
                                    }
                            }
                        }
                        .frame( maxWidth: .infinity)
                        .edgesIgnoringSafeArea(.all)
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    }.background(Color.clear)
                }
            }
            Spacer()
            VStack(alignment: .leading){
                Text(NSLocalizedString("Documentação pendente", comment: ""))
                    .font(.custom("SF Pro", size: 18)
                        .weight(.bold))
                    .foregroundColor(Color.black)
                
                HStack{
                    ScrollView{
                        VStack(alignment: .leading){
                            ForEach(0..<tasks.count, id: \.self){i in
                                pendingListCell(task: tasks[i])
                                    .padding(5)
                                    .listRowInsets(EdgeInsets())
                                    .background(overText2 == i ? Color.theme.grayListHover : Color.clear)
                                    .onHover{hovering in
                                        if hovering{
                                            overText2 = i
                                        } else {
                                            overText2 = -1
                                        }
                                    }
                            }
                        }
                    }
                }
            }
            .padding(.vertical, 20)
            Spacer()
        }
        .frame(width: 279)
        .frame(maxHeight: .infinity)
        .background(Color.theme.grayBackground)
    }
    
    
    func getPriorityFlagColor(priority: TaskPriority) -> Color {
        switch priority {
        case .HIGH:
            return Color.theme.redMain
        case .VERY_HIGH:
            return .purple
        case .MEDIUM:
            return Color.theme.orangeKanban
        case .LOW:
            return Color.theme.greenKanban
        }
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
            return NSLocalizedString(tagName.displayName, comment: "")
        }
    }
    
}



//struct DocumentationViewSideBarUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        DocumentationViewSideBarUIView(tasks: <#[TaskModel]#>)
//    }
//}
