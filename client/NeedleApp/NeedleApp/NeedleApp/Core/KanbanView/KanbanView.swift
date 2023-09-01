//
//  KanbanView.swift
//  NeedleApp
//
//  Created by Jpsmor on 04/08/23.
//

import SwiftUI

struct KanbanView: View {
<<<<<<< HEAD
    @ObservedObject var kanbanViewModel: KanbanViewModel<TaskDataService>
    
    init(tasks: [TaskModel], role: Role, selectedColumn: Binding<TaskStatus>, showPopUp: Binding<Bool>, showCard: Binding<Bool>, selectedWorkspace: Workspace, selectedTask: Binding<TaskModel?>, isEditing: Binding<Bool>) {
        
        self.kanbanViewModel = KanbanViewModel(
            localTasks: tasks,
            role: role,
            selectedColumn: selectedColumn,
            showPopUp: showPopUp,
            showCard: showCard,
            selectedWorkspace: selectedWorkspace,
            selectedTask: selectedTask,
            isEditing: isEditing,
            taskDS: .shared
        )
    }
=======
    @EnvironmentObject var kanbanViewModel: KanbanViewModel
    @EnvironmentObject var projectViewModel: ProjectViewModel
    
    @State var currentlyDragging : String?
    @State var isDeleting = false
    @State var isArchiving = false
>>>>>>> ef5e5dc4b23e2ae42ac4e2dbc9c17140fca65abe
    
    @State var taskType: TaskType? = nil
    @State var taskPriority: TaskPriority? = nil
    @State var searchText: String? = nil
    
    var body: some View {
        ZStack {
            Image("icon-bg")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 2000, alignment: .bottomTrailing)
            VStack{
                HStack{
<<<<<<< HEAD
                    DropdownTypeButton(taskType: $kanbanViewModel.taskType, dropOptions: TaskType.allCases) {}
                    DropdownPriorityButton(taskPriority: $kanbanViewModel.taskPriority, dropOptions: TaskPriority.allCases) {}
                    Spacer()
                    Group {
                        TextField("Procurar por nome, descrição, responsável...", text: $kanbanViewModel.searchText ?? "")
=======
                    DropdownTypeButton(taskType: $taskType, dropOptions: TaskType.allCases) {}
                    DropdownPriorityButton(taskPriority: $taskPriority, dropOptions: TaskPriority.allCases) {}
                    Spacer()
                    Group {
                        TextField("Procurar por nome, descrição, responsável...", text: $searchText ?? "")
>>>>>>> ef5e5dc4b23e2ae42ac4e2dbc9c17140fca65abe
                            .frame(width: 320, height: 32)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onSubmit {
                                
                            }
                        Button(action: {
                            //                            searchDocumentsViewModel.query = nil
                        }, label: {
                            Image(systemName: "arrow.counterclockwise")
                        })
                        .buttonStyle(.plain)
                    }
                }
                .padding(.top, 32)
                HStack(alignment: .center){
                    Spacer()
                    HStack(spacing: 30) {
                        TodoView()
                        DoingView()
                        InReviewView()
<<<<<<< HEAD
                        DoneView()
=======
                        doneView()
>>>>>>> ef5e5dc4b23e2ae42ac4e2dbc9c17140fca65abe
                    }
                    Spacer()
                }
                .padding(.top, 32)
                .onAppear {
<<<<<<< HEAD
                    kanbanViewModel.presentCard()
=======
                    projectViewModel.presentCard()
>>>>>>> ef5e5dc4b23e2ae42ac4e2dbc9c17140fca65abe
                }
            }
            .padding(.trailing, 64)
            .padding(.leading, 64)
<<<<<<< HEAD
        }.sheet(isPresented: $kanbanViewModel.isArchiving, content: {
=======
        }.sheet(isPresented: $isArchiving, content: {
>>>>>>> ef5e5dc4b23e2ae42ac4e2dbc9c17140fca65abe
            SheetView(type: .archiveTask)
        })
    }
    
    @ViewBuilder
    func TodoView() -> some View {
        NavigationStack {
            VStack {
                addTaskButton(status: TaskStatus.TODO)
                Spacer()
                    .frame(height: 24)
                ScrollView(.vertical) {
                    ForEach(kanbanViewModel.localTasks.filter {
                        $0.status == TaskStatus.TODO &&
<<<<<<< HEAD
                        (kanbanViewModel.searchText == nil || kanbanViewModel.searchText!.isEmpty || $0.title.lowercased().contains(kanbanViewModel.searchText!.lowercased())) &&
                        (kanbanViewModel.taskType == nil || $0.type == kanbanViewModel.taskType) &&
                        (kanbanViewModel.taskPriority == nil || $0.taskPriority == kanbanViewModel.taskPriority)
=======
                        ( searchText == nil || searchText!.isEmpty || $0.title.contains(searchText!)) &&
                        (taskType == nil || $0.type == taskType) &&
                        (taskPriority == nil || $0.taskPriority == taskPriority)
>>>>>>> ef5e5dc4b23e2ae42ac4e2dbc9c17140fca65abe
                    }) {task in
                        TaskCardView(task: task)
                            .padding(.bottom, 20)
                            .onTapGesture(count: 2) {
                                kanbanViewModel.selectedTask = task
                                kanbanViewModel.showEditTaskPopUP.toggle()
                            }
                            .buttonStyle(.plain)
                    }
                }
                .scrollIndicators(.never)
            }
        }
        .dropDestination(for: String.self) { items, location in
<<<<<<< HEAD
            kanbanViewModel.currentlyDragging = items.first
=======
            currentlyDragging = items.first
>>>>>>> ef5e5dc4b23e2ae42ac4e2dbc9c17140fca65abe
            withAnimation(.easeIn) {
                kanbanViewModel.addItem(currentlyDragging: kanbanViewModel.currentlyDragging ?? "", status: TaskStatus.TODO)
            }
            return false
        } isTargeted: { status in
        }
    }
    
    @ViewBuilder
    func DoingView() -> some View {
        NavigationStack {
            VStack {
                addTaskButton(status: TaskStatus.IN_PROGRESS)
                Spacer()
                    .frame(height: 24)
                ScrollView(.vertical) {
                    ForEach(kanbanViewModel.localTasks.filter {
                        $0.status == TaskStatus.IN_PROGRESS  &&
<<<<<<< HEAD
                        ( kanbanViewModel.searchText == nil || kanbanViewModel.searchText!.isEmpty || $0.title.lowercased().contains(kanbanViewModel.searchText!.lowercased())) &&
                        (kanbanViewModel.taskType == nil || $0.type == kanbanViewModel.taskType) &&
                        (kanbanViewModel.taskPriority == nil || $0.taskPriority == kanbanViewModel.taskPriority)
=======
                        ( searchText == nil || searchText!.isEmpty || $0.title.contains(searchText!)) &&
                        (taskType == nil || $0.type == taskType) &&
                        (taskPriority == nil || $0.taskPriority == taskPriority)
>>>>>>> ef5e5dc4b23e2ae42ac4e2dbc9c17140fca65abe
                    }){task in
                        TaskCardView(task: task)
                            .padding(.bottom, 20)
                            .onTapGesture(count: 2) {
                                kanbanViewModel.selectedTask = task
                                kanbanViewModel.showEditTaskPopUP.toggle()
                            }
                            .buttonStyle(.plain)
                    }
                }
                .scrollIndicators(.never)
            }
        }
        .dropDestination(for: String.self) { items, location in
<<<<<<< HEAD
            kanbanViewModel.currentlyDragging = items.first
=======
            currentlyDragging = items.first
>>>>>>> ef5e5dc4b23e2ae42ac4e2dbc9c17140fca65abe
            withAnimation(.easeIn) {
                kanbanViewModel.addItem(currentlyDragging: kanbanViewModel.currentlyDragging ?? "", status: TaskStatus.IN_PROGRESS)
            }
            return false
        } isTargeted: { status in
        }
    }
    
    @ViewBuilder
    func InReviewView() -> some View {
        NavigationStack {
            VStack {
                addTaskButton(status: TaskStatus.PENDING)
                Spacer()
                    .frame(height: 24)
                ScrollView(.vertical) {
                    ForEach(kanbanViewModel.localTasks.filter {
                        $0.status == TaskStatus.PENDING &&
<<<<<<< HEAD
                        ( kanbanViewModel.searchText == nil || kanbanViewModel.searchText!.isEmpty || $0.title.lowercased().contains(kanbanViewModel.searchText!.lowercased())) &&
                        (kanbanViewModel.taskType == nil || $0.type == kanbanViewModel.taskType) &&
                        (kanbanViewModel.taskPriority == nil || $0.taskPriority == kanbanViewModel.taskPriority)
=======
                        ( searchText == nil || searchText!.isEmpty || $0.title.contains(searchText!)) &&
                        (taskType == nil || $0.type == taskType) &&
                        (taskPriority == nil || $0.taskPriority == taskPriority)
>>>>>>> ef5e5dc4b23e2ae42ac4e2dbc9c17140fca65abe
                    }) {task in
                        TaskCardView(task: task)
                            .padding(.bottom, 20)
                            .onTapGesture(count: 2) {
                                kanbanViewModel.selectedTask = task
                                kanbanViewModel.showEditTaskPopUP.toggle()
                            }
                            .buttonStyle(.plain)
                    }
                }
                .scrollIndicators(.never)
            }
        }
        .dropDestination(for: String.self) { items, location in
<<<<<<< HEAD
            kanbanViewModel.currentlyDragging = items.first
=======
            currentlyDragging = items.first
>>>>>>> ef5e5dc4b23e2ae42ac4e2dbc9c17140fca65abe
            withAnimation(.easeIn) {
                kanbanViewModel.addItem(currentlyDragging: kanbanViewModel.currentlyDragging ?? "", status: TaskStatus.PENDING)
            }
            return false
        } isTargeted: { status in
        }
    }
    
    @ViewBuilder
    func DoneView() -> some View {
        NavigationStack {
            VStack {
                addTaskButton(status: TaskStatus.DONE)
                Spacer()
                    .frame(height: 24)
                ScrollView(.vertical) {
                    ForEach(kanbanViewModel.localTasks.filter {
                        $0.status == TaskStatus.DONE  &&
<<<<<<< HEAD
                        ( kanbanViewModel.searchText == nil || kanbanViewModel.searchText!.isEmpty || $0.title.lowercased().contains(kanbanViewModel.searchText!.lowercased())) &&
                        (kanbanViewModel.taskType == nil || $0.type == kanbanViewModel.taskType) &&
                        (kanbanViewModel.taskPriority == nil || $0.taskPriority == kanbanViewModel.taskPriority)
=======
                        ( searchText == nil || searchText!.isEmpty || $0.title.contains(searchText!)) &&
                        (taskType == nil || $0.type == taskType) &&
                        (taskPriority == nil || $0.taskPriority == taskPriority)
>>>>>>> ef5e5dc4b23e2ae42ac4e2dbc9c17140fca65abe
                    }) {task in
                        TaskCardView(task: task)
                            .padding(.bottom, 20)
                            .onTapGesture(count: 2) {
                                kanbanViewModel.selectedTask = task
                                kanbanViewModel.showEditTaskPopUP.toggle()
                            }
                            .buttonStyle(.plain)
                    }
                }
                .scrollIndicators(.never)
            }
        }
        .dropDestination(for: String.self) { items, location in
            if kanbanViewModel.role.displayName != Role.PRODUCT_MANAGER.rawValue {
                return false
            }
            
<<<<<<< HEAD
            kanbanViewModel.currentlyDragging = items.first
=======
            currentlyDragging = items.first
>>>>>>> ef5e5dc4b23e2ae42ac4e2dbc9c17140fca65abe
            withAnimation(.easeIn) {
                kanbanViewModel.addItem(currentlyDragging: kanbanViewModel.currentlyDragging ?? "", status: TaskStatus.DONE)
            }
            return false
        } isTargeted: { status in
        }
    }
<<<<<<< HEAD
=======
    
    @ViewBuilder
    func addTaskButton(status : TaskStatus) -> some View {
        Button {
            if status == .DONE && projectViewModel.roles[projectViewModel.selectedProject.id]! != Role.PRODUCT_MANAGER.rawValue {
                return
            }
            
            projectViewModel.showPopUp.toggle()
            projectViewModel.selectedColumnStatus = status
        } label: {
            HStack(alignment: .center, spacing: 8) {
                Image(systemName: "plus")
                    .font(
                        Font.custom("SF Pro", size: 16)
                            .weight(.medium)
                    )
                    .foregroundColor(.black)
                Spacer()
                    .frame(width: 8)
                Text("Adicionar Task")
                    .font(
                        Font.custom("SF Pro", size: 12)
                            .weight(.semibold)
                    )
                    .foregroundColor(.black)
            }
            .padding(5)
            .frame(minWidth: 128, maxWidth: 1000)
            .frame(height: 48)
            .background(Color(red: 0.88, green: 1, blue: 0.74))
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .inset(by: 0.5)
                    .stroke(.black, style: StrokeStyle(lineWidth: 1, dash: [6, 6]))
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
>>>>>>> ef5e5dc4b23e2ae42ac4e2dbc9c17140fca65abe
}


