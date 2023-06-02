//
//  kanban.swift
//  Needle
//
//  Created by matheusvb on 25/05/23.
//
import SwiftUI
import UniformTypeIdentifiers

struct TaskCard: Identifiable {
    let id = UUID()
    let title: String
    let tagType: String
    var column: TaskColumn
}

enum TaskColumn: String, CaseIterable {
    case toDo = "to do"
    case inProgress = "doing"
    case inReviw = "in review"
    case done = "done"
    
}

struct KanbanComponentView: View {
    @State var tasks: [TaskCard] = [
        TaskCard(title: "Task 1", tagType: "dev", column: .toDo),
        TaskCard(title: "Task 2", tagType: "design", column: .toDo),
        TaskCard(title: "Task 3", tagType: "dev", column: .done),
        TaskCard(title: "Task 4", tagType: "geral", column: .done),
        //        TaskCard(title: "Task 5", tagType: "design", column: .inReviw),
        //        TaskCard(title: "Task 6", tagType: "design", column: .toDo),
        //        TaskCard(title: "Task 7", tagType: "design", column: .toDo),
        //        TaskCard(title: "Task 8", tagType: "dev", column: .toDo),
    ]
    
    let workspaceName: String
    
    @State var taskIndex = 0
    
    var body: some View {
        VStack{
            HStack{
                Text(workspaceName)
                    .padding(10)
                    .foregroundColor(.black)
                    .font(.custom(.spaceGroteskSemiBold, size: 40))
                Spacer()
            }
            HStack {
                ForEach(TaskColumn.allCases, id: \.self) { column in
                    VStack {
                        KanbanColumnTitle(title: column)
                            .font(.custom(.spaceGrotesk, size: 24))
                        
                        Spacer().frame(height: 28)
                        
                        VStack (spacing: 24){
                            ForEach(tasks.filter { $0.column == column }) { task in
                                
                                KanbanTaskComponentView(TaskTitle: task.title, TaskTagType: task.tagType, columm: task.column)
                                    .onDrag {
                                        taskIndex = $tasks.firstIndex { $0.id == task.id } ?? 0
                                        return NSItemProvider(object: "\(taskIndex)" as NSString)
                                    }
                            }
                            
                        }.frame(maxWidth: 282, alignment: .top)
                        
                        
                        Spacer()
                        
                    }.foregroundColor(.black)
                        .onDrop(of: [.text], delegate: TaskDropDelegate(column: column, tasks: $tasks, taskIndex: taskIndex))
                    
                }
            }.background(.clear)
                .frame(width: 1180)
        }
    }
}

struct TaskDropDelegate: DropDelegate {
    let column: TaskColumn
    @Binding var tasks: [TaskCard]
    let taskIndex: Int
    
    func performDrop(info: DropInfo) -> Bool {
        
        tasks[taskIndex].column = column
        return true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        KanbanComponentView(workspaceName: "Projeto Teste")
    }
}
