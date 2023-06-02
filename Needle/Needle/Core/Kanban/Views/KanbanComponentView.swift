//
//  kanban.swift
//  Needle
//
//  Created by matheusvb on 25/05/23.
//
import SwiftUI
import UniformTypeIdentifiers

struct TaskCard: Identifiable {
    let id: String
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
    @ObservedObject var kanbanComponentViewModel = KanbanComponentViewModel()
    
    @State var tasks: [TaskCard] = []
    
    let workspaceName: String
    let workspaceId: String
    
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
                                NavigationLink(destination: DocumentView(text: NSAttributedString(string: ""), taskId: task.id), label: {
                                    KanbanTaskComponentView(TaskTitle: task.title, TaskTagType: task.tagType, columm: task.column)
                                })
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
        }.onAppear {
            Task {
                let rawTasks = await kanbanComponentViewModel.taskService.returnWorkspaceTasks(workspaceId: workspaceId)
                print(rawTasks.count)
                for task in rawTasks {
                    var column = TaskColumn.toDo
                    
                    switch task.status {
                    case "TODO": column = TaskColumn.toDo
                    case "IN_PROGRESS": column = TaskColumn.inProgress
                    case "PENDING": column = TaskColumn.inReviw
                    case "DONE": column = TaskColumn.done
                    default: column = TaskColumn.toDo
                    }
                    
                    let card = TaskCard(id: task.id,title: task.title, tagType: task.type, column: column)
                    tasks.append(card)
                }
            }
        }
    }
}

struct TaskDropDelegate: DropDelegate {
    let column: TaskColumn
    @Binding var tasks: [TaskCard]
    let taskIndex: Int
    
    let taskService = TaskService(baseUrl: _URL)
    
    func performDrop(info: DropInfo) -> Bool {
        
        tasks[taskIndex].column = column
        print(column)
        
        var status: String = ""
        
        switch column {
        case .done: status = "DONE"
        case .inProgress: status = "IN_PROGRESS"
        case .inReviw: status = "PENDING"
        case .toDo: status = "TODO"
        }
        
        taskService.updateStatus(taskId: tasks[taskIndex].id, status: status) { result in
            if let result = result {
                print(result)
            } else {
                print("ERRO")
            }
        }
        return true
    }
}

