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
    var column: TaskColumn
}

enum TaskColumn: String, CaseIterable {
    case toDo = "To Do"
    case inProgress = "In Progress"
    case inReviw = "In review"
    case done = "Done"
    
}

struct ContentView: View {
    @State var tasks: [Task] = [
        Task(title: "Task 1", column: .toDo),
        Task(title: "Task 2", column: .toDo),
        Task(title: "Task 3", column: .done)
    ]

    var body: some View {
        HStack {
            ForEach(TaskColumn.allCases, id: \.self) { column in
                VStack {
                    Text(column.rawValue)
                        .font(.title)
                    List {
                        ForEach(tasks.filter { $0.column == column }) { task in
                            
                            KanbanTaskComponentView()
                                .onDrag {
                                    let index = tasks.firstIndex { $0.id == task.id } ?? 0
                                    return NSItemProvider(object: "\(index)" as NSString)
                                }
                        }
                        .onDrop(of: [.text], delegate: TaskDropDelegate(column: column, tasks: $tasks))
                    }
                }.foregroundColor(.black)
            }
        }.background(.white)
    }
}

struct TaskDropDelegate: DropDelegate {
    let column: TaskColumn
        @Binding var tasks: [Task]

        func performDrop(info: DropInfo) -> Bool {
            if let item = info.itemProviders(for: [.text]).first {
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
        ContentView()
    }
}
