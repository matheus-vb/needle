//
//  kanban.swift
//  Needle
//
//  Created by matheusvb on 25/05/23.
//
import SwiftUI
import UniformTypeIdentifiers

struct Task: Identifiable {
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
    @State var tasks: [Task] = [
        Task(title: "Task 1", tagType: "dev", column: .toDo),
        Task(title: "Task 2", tagType: "design", column: .toDo),
        Task(title: "Task 3", tagType: "dev", column: .done),
        Task(title: "Task 4", tagType: "geral", column: .inProgress),
        Task(title: "Task 5", tagType: "design", column: .inReviw),
        Task(title: "Task 6", tagType: "design", column: .toDo),
        Task(title: "Task 6", tagType: "design", column: .toDo),
        Task(title: "Task 6", tagType: "dev", column: .toDo),
    ]

    var body: some View {
        HStack {
            ForEach(TaskColumn.allCases, id: \.self) { column in
                VStack {
                    KanbanColumnTitle(title: column)
                    
                    Spacer().frame(height: 28)
                    
                    VStack {
                        ForEach(tasks.filter { $0.column == column }) { task in
                            
                            KanbanTaskComponentView(TaskTitle: task.title, TaskTagType: task.tagType, columm: task.column)
                                .onDrag {
                                    let index = tasks.firstIndex { $0.id == task.id } ?? 0
                                    return NSItemProvider(object: "\(index)" as NSString)
                                }
                            Spacer().frame(height: 24)
                        }
                        .onDrop(of: [.text], delegate: TaskDropDelegate(column: column, tasks: $tasks))
                    }.frame(width: 282)
                    Spacer()
                    
                }.foregroundColor(.black)
                    
            }
        }.background(.white)
            .frame(width: 1180)
    }
}

struct TaskDropDelegate: DropDelegate {
    let column: TaskColumn
    @Binding var tasks: [Task]

        func performDrop(info: DropInfo) -> Bool {
            if let item = info.itemProviders(for: [.text]).first {
                print(item)
                item.loadItem(forTypeIdentifier: UTType.text.identifier, options: nil) { (data, error) in
                    DispatchQueue.main.async {
                        if let data = data as? Data, let index = String(data: data, encoding: .utf8), let i = Int(index) {
                            tasks[i].column = column
                        }
                    }
                }
                return true
            } else {
                return false
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        KanbanComponentView()
    }
}
