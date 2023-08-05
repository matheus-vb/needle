//
//  KanbanView.swift
//  NeedleApp
//
//  Created by Jpsmor on 04/08/23.
//

import SwiftUI

struct KanbanView: View {
    @State var tasks : [TaskModel]
    @State var currentlyDragging : String?
    
    @EnvironmentObject var projectViewModel: ProjectViewModel
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            HStack(spacing: 30) {
                TodoView()
                DoingView()
                InReviewView()
                doneView()
                Spacer()
                    .frame(minWidth: 60)
            }
            Spacer()
        }
    }
    
    func addItem(currentlyDragging: String, status: TaskStatus) {
        if let sourceIndex = self.tasks.firstIndex(where: {
            $0.id == currentlyDragging
        }){
            var sourceItem = self.tasks.remove(at: sourceIndex)
            sourceItem.status = status.rawValue
            self.tasks.append(sourceItem)
            TaskDataService.shared.updateTaskStatus(taskId: currentlyDragging, status: status, userId: AuthenticationManager.shared.user!.id, workspaceId: projectViewModel.selectedProject.id)
        }
    }
    func swapItem(droppingTask: TaskModel, currentlyDragging: String) {
        if let sourceIndex = self.tasks.firstIndex(where: {
            $0.id == currentlyDragging
        }), let destinationIndex = self.tasks.firstIndex(where: {
            $0.id == droppingTask.id
        }) {
            var sourceItem = self.tasks.remove(at: sourceIndex)
            sourceItem.status = droppingTask.status
            self.tasks.insert(sourceItem, at: destinationIndex)
        }
    }
    
    @ViewBuilder
    func TodoView() -> some View {
        NavigationStack {
            VStack {
                KanbanColumnTitleView(rowName: "A fazer", color: Color(red: 0.94, green: 0.27, blue: 0.27))
                Spacer()
                    .frame(height: 24)
                addTaskButton(status: TaskStatus.TODO.rawValue)
                Spacer()
                    .frame(height: 24)
                ScrollView(.vertical) {
                    ForEach(tasks.filter {
                        $0.status == TaskStatus.TODO.rawValue
                    }) {task in
                        TaskCardView(task: task)
                            .padding(.bottom, 20)
                    }
                }
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
                KanbanColumnTitleView(rowName: "Fazendo", color: Color(red: 0.94, green: 0.27, blue: 0.27))
                Spacer()
                    .frame(height: 24)
                addTaskButton(status: TaskStatus.IN_PROGRESS.rawValue)
                Spacer()
                    .frame(height: 24)
                ScrollView(.vertical) {
                    ForEach(tasks.filter {
                        $0.status == TaskStatus.IN_PROGRESS.rawValue
                    }) {task in
                        TaskCardView(task: task)
                            .padding(.bottom, 20)
                    }
                }
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
                KanbanColumnTitleView(rowName: "Em revisão", color: Color(red: 0.23, green: 0.51, blue: 0.96))
                Spacer()
                    .frame(height: 24)
                addTaskButton(status: TaskStatus.PENDING.rawValue)
                Spacer()
                    .frame(height: 24)
                ScrollView(.vertical) {
                    ForEach(tasks.filter {
                        $0.status == TaskStatus.PENDING.rawValue
                    }) {task in
                        TaskCardView(task: task)
                            .padding(.bottom, 20)
                    }
                }
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
                KanbanColumnTitleView(rowName: "Feito", color: Color(red: 0.98, green: 0.45, blue: 0.09))
                Spacer()
                    .frame(height: 24)
                addTaskButton(status: TaskStatus.DONE.rawValue)
                Spacer()
                    .frame(height: 24)
                ScrollView(.vertical) {
                    ForEach(tasks.filter {
                        $0.status == TaskStatus.DONE.rawValue
                    }) {task in
                        TaskCardView(task: task)
                            .padding(.bottom, 20)
                    }
                }
            }
        }
        .dropDestination(for: String.self) { items, location in
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
    func addTaskButton(status : String) -> some View {
        Button {
            self.tasks.append(TaskModel(id: UUID.init().uuidString, title: "Insira o titulo de sua task", description: "Descreva, em poucas palavras, sua task", status: status, type: TaskType.GENERAL.rawValue, documentId: nil, endDate: "00/00/00", workId: UUID.init().uuidString, document: nil))
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
            .padding(0)
            .frame(width: 256, height: 48, alignment: .center)
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
