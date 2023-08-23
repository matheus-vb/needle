//
//  KanbanView.swift
//  NeedleApp
//
//  Created by Jpsmor on 04/08/23.
//

import SwiftUI

struct KanbanView: View {
    @ObservedObject var kanbanViewModel: KanbanViewModel
    
    init(tasks: [TaskModel], role: Role, selectedColumn: Binding<TaskStatus>, showPopUp: Binding<Bool>, showCard: Binding<Bool>, selectedWorkspace: Workspace, selectedTask: Binding<TaskModel?>, isEditing: Binding<Bool>) {
        
        self.kanbanViewModel = KanbanViewModel(
            localTasks: tasks,
            role: role,
            selectedColumn: selectedColumn,
            showPopUp: showPopUp,
            showCard: showCard,
            selectedWorkspace: selectedWorkspace,
            selectedTask: selectedTask,
            isEditing: isEditing
        )
    }
    
    var body: some View {
        ZStack {
            Image("icon-bg")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 2000, alignment: .bottomTrailing)
            HStack(alignment: .center) {
                Spacer()
                HStack(spacing: 30) {
                    TodoView()
                    DoingView()
                    InReviewView()
                    doneView()
                }
                Spacer()
            }
            .padding(.top, 32)
            .padding(.leading, 64)
            .padding(.trailing, 64)
            .onAppear {
                kanbanViewModel.presentCard()
            }
        }.sheet(isPresented: $kanbanViewModel.isArchiving, content: {
            SheetView(type: .archiveTask)
        })
    }
    
    func addItem(currentlyDragging: String, status: TaskStatus) {
        if let sourceIndex = kanbanViewModel.localTasks.firstIndex(where: {
            $0.id == currentlyDragging
        }){
            var sourceItem = kanbanViewModel.localTasks.remove(at: sourceIndex)
            sourceItem.status = status
            kanbanViewModel.localTasks.append(sourceItem)
            TaskDataService.shared.updateTaskStatus(taskId: currentlyDragging, status: status, userId: AuthenticationManager.shared.user!.id, workspaceId: kanbanViewModel.selectedWorkspace.id)
        }
    }
    func swapItem(droppingTask: TaskModel, currentlyDragging: String) {
        if let sourceIndex = kanbanViewModel.localTasks.firstIndex(where: {
            $0.id == currentlyDragging
        }), let destinationIndex = kanbanViewModel.localTasks.firstIndex(where: {
            $0.id == droppingTask.id
        }) {
            var sourceItem = kanbanViewModel.localTasks.remove(at: sourceIndex)
            sourceItem.status = droppingTask.status
            kanbanViewModel.localTasks.insert(sourceItem, at: destinationIndex)
        }
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
                        $0.status == TaskStatus.TODO
                    }) {task in
                        TaskCardView(task: task)
                            .padding(.bottom, 20)
                        .buttonStyle(.plain)
                    }
                }
                .scrollIndicators(.never)
            }
        }
        .dropDestination(for: String.self) { items, location in
            kanbanViewModel.currentlyDragging = items.first
            
            withAnimation(.easeIn) {
                addItem(currentlyDragging: kanbanViewModel.currentlyDragging ?? "", status: TaskStatus.TODO)
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
                        $0.status == TaskStatus.IN_PROGRESS
                    }){task in
                        TaskCardView(task: task)
                            .padding(.bottom, 20)
                        .buttonStyle(.plain)
                    }
                }
                .scrollIndicators(.never)
            }
        }
        .dropDestination(for: String.self) { items, location in
            kanbanViewModel.currentlyDragging = items.first
//                print("drop destination!")
            withAnimation(.easeIn) {
                addItem(currentlyDragging: kanbanViewModel.currentlyDragging ?? "", status: TaskStatus.IN_PROGRESS)
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
                        $0.status == TaskStatus.PENDING
                    }) {task in
                        TaskCardView(task: task)
                            .padding(.bottom, 20)
                        .buttonStyle(.plain)
                    }
                }
                .scrollIndicators(.never)
            }
        }
        .dropDestination(for: String.self) { items, location in
            kanbanViewModel.currentlyDragging = items.first
//                print("drop destination!")
            withAnimation(.easeIn) {
                addItem(currentlyDragging: kanbanViewModel.currentlyDragging ?? "", status: TaskStatus.PENDING)
            }
            return false
        } isTargeted: { status in
        }
    }
    
    @ViewBuilder
    func doneView() -> some View {
        NavigationStack {
            VStack {
                addTaskButton(status: TaskStatus.DONE)
                Spacer()
                    .frame(height: 24)
                ScrollView(.vertical) {
                    ForEach(kanbanViewModel.localTasks.filter {
                        $0.status == TaskStatus.DONE
                    }) {task in
                        TaskCardView(task: task)
                            .padding(.bottom, 20)
                        .buttonStyle(.plain)
                    }
                }
                .scrollIndicators(.never)
            }
        }
        .dropDestination(for: String.self) { items, location in
            if kanbanViewModel.role != Role.PRODUCT_MANAGER {
                return false
            }
            
            kanbanViewModel.currentlyDragging = items.first
//                print("drop destination!")
            withAnimation(.easeIn) {
                addItem(currentlyDragging: kanbanViewModel.currentlyDragging ?? "", status: TaskStatus.DONE)
            }
            return false
        } isTargeted: { status in
        }
    }
    
    @ViewBuilder
    func addTaskButton(status : TaskStatus) -> some View {
        Button {
            if status == .DONE && kanbanViewModel.role != Role.PRODUCT_MANAGER {
                return
            }
            
            kanbanViewModel.showPopUp.toggle()
            kanbanViewModel.selectedColumn = status
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
            .modifier(AddTaskButtonBackground())
            .cornerRadius(6)
            .overlay(
              RoundedRectangle(cornerRadius: 6)
                .inset(by: 0.5)
                .stroke(.black, style: StrokeStyle(lineWidth: 1, dash: [6, 6]))
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
}


