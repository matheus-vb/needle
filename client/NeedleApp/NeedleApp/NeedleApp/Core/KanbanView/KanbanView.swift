//
//  KanbanView.swift
//  NeedleApp
//
//  Created by Jpsmor on 04/08/23.
//

import SwiftUI

struct KanbanView: View {
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
                    DropdownTypeButton(taskType: $kanbanViewModel.taskType, dropOptions: TaskType.allCases) {}
                    DropdownPriorityButton(taskPriority: $kanbanViewModel.taskPriority, dropOptions: TaskPriority.allCases) {}
                    Spacer()
                    Group {
                        HStack {
                            TextField("Procurar por nome, descrição, responsável...", text: $kanbanViewModel.searchText ?? "")
                                .frame(width: 320, height: 32)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onSubmit {
                                    
                                }
                                .modifier(searchFieldModifier())
                        }
                        Button(action: {
                            kanbanViewModel.searchText = ""
                        }, label: {
                            Image(systemName: "delete.left")
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
                        DoneView()
                    }
                    Spacer()
                }
                .padding(.top, 32)
                .onAppear {
                    kanbanViewModel.presentCard()
                }
            }
            .padding(.trailing, 64)
            .padding(.leading, 64)
        }.sheet(isPresented: $kanbanViewModel.isArchiving, content: {
            SheetView(type: .archiveTask)
        })
        
    }
    
    @ViewBuilder
    func TodoView() -> some View {
        NavigationStack {
            VStack {
                addTaskButton(status: TaskStatus.TODO)
                    .keyboardShortcut("n", modifiers: .command)
                Spacer()
                    .frame(height: 24)
                ScrollView(.vertical) {
                    ForEach(kanbanViewModel.localTasks.filter {
                        $0.status == TaskStatus.TODO &&
                        (kanbanViewModel.searchText == nil || kanbanViewModel.searchText!.isEmpty || $0.title.lowercased().contains(kanbanViewModel.searchText!.lowercased())) &&
                        (kanbanViewModel.taskType == nil || $0.type == kanbanViewModel.taskType) &&
                        (kanbanViewModel.taskPriority == nil || $0.taskPriority == kanbanViewModel.taskPriority)
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
            kanbanViewModel.currentlyDragging = items.first
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
                        ( kanbanViewModel.searchText == nil || kanbanViewModel.searchText!.isEmpty || $0.title.lowercased().contains(kanbanViewModel.searchText!.lowercased())) &&
                        (kanbanViewModel.taskType == nil || $0.type == kanbanViewModel.taskType) &&
                        (kanbanViewModel.taskPriority == nil || $0.taskPriority == kanbanViewModel.taskPriority)
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
            kanbanViewModel.currentlyDragging = items.first
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
                        ( kanbanViewModel.searchText == nil || kanbanViewModel.searchText!.isEmpty || $0.title.lowercased().contains(kanbanViewModel.searchText!.lowercased())) &&
                        (kanbanViewModel.taskType == nil || $0.type == kanbanViewModel.taskType) &&
                        (kanbanViewModel.taskPriority == nil || $0.taskPriority == kanbanViewModel.taskPriority)
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
            kanbanViewModel.currentlyDragging = items.first
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
                        ( kanbanViewModel.searchText == nil || kanbanViewModel.searchText!.isEmpty || $0.title.lowercased().contains(kanbanViewModel.searchText!.lowercased())) &&
                        (kanbanViewModel.taskType == nil || $0.type == kanbanViewModel.taskType) &&
                        (kanbanViewModel.taskPriority == nil || $0.taskPriority == kanbanViewModel.taskPriority)
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
            
            kanbanViewModel.currentlyDragging = items.first
            withAnimation(.easeIn) {
                kanbanViewModel.addItem(currentlyDragging: kanbanViewModel.currentlyDragging ?? "", status: TaskStatus.DONE)
            }
            return false
        } isTargeted: { status in
        }
    }
}


