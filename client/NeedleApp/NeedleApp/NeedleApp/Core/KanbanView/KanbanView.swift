//
//  KanbanView.swift
//  NeedleApp
//
//  Created by Jpsmor on 04/08/23.
//

import SwiftUI

struct KanbanView: View {
    @State var currentlyDragging : String?
    @EnvironmentObject var kanbanViewModel: KanbanViewModel
    @EnvironmentObject var projectViewModel: ProjectViewModel
    
    @State var isDeleting = false
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            HStack(spacing: 30) {
                TodoView()
                DoingView()
                InReviewView()
                doneView()
//                Spacer()
//                    .frame(width: 60)
            }
            Spacer()
        }
        .padding(.top, 32)
        .padding(.leading, 64)
        .padding(.trailing, 64)
        .onAppear {
            projectViewModel.presentCard()
        }
    }
    
    func addItem(currentlyDragging: String, status: TaskStatus) {
        if let sourceIndex = kanbanViewModel.localTasks.firstIndex(where: {
            $0.id == currentlyDragging
        }){
            var sourceItem = kanbanViewModel.localTasks.remove(at: sourceIndex)
            sourceItem.status = status
            kanbanViewModel.localTasks.append(sourceItem)
            TaskDataService.shared.updateTaskStatus(taskId: currentlyDragging, status: status, userId: AuthenticationManager.shared.user!.id, workspaceId: projectViewModel.selectedProject.id)
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
                            .onTapGesture(count: 2) {
                                projectViewModel.selectedTask = task
                                projectViewModel.showEditTaskPopUP.toggle()
                            }
                        .buttonStyle(.plain)
                    }
                }
                .scrollIndicators(.never)
            }
        }
        .dropDestination(for: String.self) { items, location in
            currentlyDragging = items.first
//                print("drop destination!")
            withAnimation(.easeIn) {
                addItem(currentlyDragging: currentlyDragging ?? "", status: TaskStatus.TODO)
            }
            return false
        } isTargeted: { status in
        }
    }
    
    @ViewBuilder
    func DoingView() -> some View {
        NavigationStack {
            VStack {
                KanbanColumnTitleView(rowName: "Fazendo", color: Color.theme.blueKanban)
                Spacer()
                    .frame(height: 24)
                addTaskButton(status: TaskStatus.IN_PROGRESS)
                Spacer()
                    .frame(height: 24)
                ScrollView(.vertical) {
                    ForEach(kanbanViewModel.localTasks.filter {
                        $0.status == TaskStatus.IN_PROGRESS
                    }){task in
                        TaskCardView(task: task)
                            .padding(.bottom, 20)
                            .onTapGesture(count: 2) {
                                projectViewModel.selectedTask = task
                                projectViewModel.showEditTaskPopUP.toggle()
                            }
                        .buttonStyle(.plain)
                    }
                }
                .scrollIndicators(.never)
            }
        }
        .dropDestination(for: String.self) { items, location in
            currentlyDragging = items.first
//                print("drop destination!")
            withAnimation(.easeIn) {
                addItem(currentlyDragging: currentlyDragging ?? "", status: TaskStatus.IN_PROGRESS)
            }
            return false
        } isTargeted: { status in
        }
    }
    
    @ViewBuilder
    func InReviewView() -> some View {
        NavigationStack {
            VStack {
                KanbanColumnTitleView(rowName: "Em revisão", color: Color.theme.orangeKanban)
                Spacer()
                    .frame(height: 24)
                addTaskButton(status: TaskStatus.PENDING)
                Spacer()
                    .frame(height: 24)
                ScrollView(.vertical) {
                    ForEach(kanbanViewModel.localTasks.filter {
                        $0.status == TaskStatus.PENDING
                    }) {task in
                        TaskCardView(task: task)
                            .padding(.bottom, 20)
                            .onTapGesture(count: 2) {
                                projectViewModel.selectedTask = task
                                projectViewModel.showEditTaskPopUP.toggle()
                            }
                        .buttonStyle(.plain)
                    }
                }
                .scrollIndicators(.never)
            }
        }
        .dropDestination(for: String.self) { items, location in
            currentlyDragging = items.first
//                print("drop destination!")
            withAnimation(.easeIn) {
                addItem(currentlyDragging: currentlyDragging ?? "", status: TaskStatus.PENDING)
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
                            .onTapGesture(count: 2) {
                                projectViewModel.selectedTask = task
                                projectViewModel.showEditTaskPopUP.toggle()
                            }
                        .buttonStyle(.plain)
                    }
                }
                .scrollIndicators(.never)
            }
        }
        .dropDestination(for: String.self) { items, location in
            if projectViewModel.roles[projectViewModel.selectedProject.id]! != Role.PRODUCT_MANAGER.rawValue {
                return false
            }
            
            currentlyDragging = items.first
//                print("drop destination!")
            withAnimation(.easeIn) {
                addItem(currentlyDragging: currentlyDragging ?? "", status: TaskStatus.DONE)
            }
            return false
        } isTargeted: { status in
        }
    }
    
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
                Text("􀅼")
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
//            .frame(width: 256, height: 48, alignment: .center)
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
    
}
