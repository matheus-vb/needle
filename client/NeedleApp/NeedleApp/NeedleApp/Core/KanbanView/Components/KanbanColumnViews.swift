//
//  KanbanColumnViews.swift
//  NeedleApp
//
//  Created by Jpsmor on 23/08/23.
//

import SwiftUI
import Firebase

extension KanbanView {
    
    @ViewBuilder
    func TodoView() -> some View {
        VStack {
            ColumnTitle(status: .TODO, color: Color.theme.yellowKanban)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.theme.grayColumn)
                    .padding(.bottom, -10)
                NavigationStack {
                    Spacer()
                        .frame(height: 10)
                    VStack {
                        ScrollView(.vertical) {
                            ForEach(kanbanViewModel.localTasks.filter {
                                $0.status == TaskStatus.TODO &&
                                (kanbanViewModel.searchText == nil || kanbanViewModel.searchText!.isEmpty || $0.title.lowercased().contains(kanbanViewModel.searchText!.lowercased())) &&
                                (kanbanViewModel.taskType == nil || $0.type == kanbanViewModel.taskType) &&
                                (kanbanViewModel.taskPriority == nil || $0.taskPriority == kanbanViewModel.taskPriority) && (($0.isVisible == true) || (showArchived == true))
                            }.sorted(by: { task1, task2 in
                                task1.updated_at > task2.updated_at
                            })) { task in
                                TaskCardView(task: task)
                                    //.padding(.top, 10)
                                    .padding(.horizontal, 10)
//                                    .onTapGesture(count: 2) {
//                                        kanbanViewModel.selectedTask = task
//                                        kanbanViewModel.showEditTaskPopUP.toggle()
//                                    }
                                    .buttonStyle(.plain)
                            }
                        }
                        .scrollIndicators(.never)
                    }
                }
                .frame(minWidth: 135)
            }
            .dropDestination(for: String.self) { items, location in
                kanbanViewModel.currentlyDragging = items.first
                self.disableTap = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.disableTap = false
                }
                withAnimation(.easeIn) {
                    kanbanViewModel.addItem(currentlyDragging: kanbanViewModel.currentlyDragging ?? "", status: TaskStatus.TODO)
                }
                return false
            } isTargeted: { status in
            }
        }
    }
    
    @ViewBuilder
    func DoingView() -> some View {
        VStack {
            ColumnTitle(status: .IN_PROGRESS, color: Color.theme.blueKanban)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.theme.grayColumn)
                    .padding(.bottom, -10)
                
                NavigationStack {
                    VStack {
                        Spacer()
                            .frame(height: 10)
                        
                        ScrollView(.vertical) {
                            ForEach(kanbanViewModel.localTasks.filter {
                                $0.status == TaskStatus.IN_PROGRESS  &&
                                ( kanbanViewModel.searchText == nil || kanbanViewModel.searchText!.isEmpty || $0.title.lowercased().contains(kanbanViewModel.searchText!.lowercased())) &&
                                (kanbanViewModel.taskType == nil || $0.type == kanbanViewModel.taskType) &&
                                (kanbanViewModel.taskPriority == nil || $0.taskPriority == kanbanViewModel.taskPriority) && (($0.isVisible == true) || (showArchived == true))
                            }.sorted(by: { task1, task2 in
                                task1.updated_at > task2.updated_at
                            })){task in
                                TaskCardView(task: task)
                                    .padding(.horizontal, 10)
//                                    .onTapGesture(count: 2) {
//                                        kanbanViewModel.selectedTask = task
//                                        kanbanViewModel.showEditTaskPopUP.toggle()
//                                    }
                                    .buttonStyle(.plain)
                            }
                        }
                        .scrollIndicators(.never)
                    }
                }
                .frame(minWidth: 135)
            }
            .dropDestination(for: String.self) { items, location in
                kanbanViewModel.currentlyDragging = items.first
                self.disableTap = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.disableTap = false
                }
                withAnimation(.easeIn) {
                    kanbanViewModel.addItem(currentlyDragging: kanbanViewModel.currentlyDragging ?? "", status: TaskStatus.IN_PROGRESS)
                }
                return false
            } isTargeted: { status in
            }
        }
    }
    
    @ViewBuilder
    func InReviewView() -> some View {
        VStack {
            ColumnTitle(status: .PENDING, color: Color.theme.orangeKanban)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.theme.grayColumn)
                    .padding(.bottom, -10)
                NavigationStack {
                    Spacer()
                        .frame(height: 10)
                    
                    VStack {
                        ScrollView(.vertical) {
                            ForEach(kanbanViewModel.localTasks.filter {
                                $0.status == TaskStatus.PENDING &&
                                ( kanbanViewModel.searchText == nil || kanbanViewModel.searchText!.isEmpty || $0.title.lowercased().contains(kanbanViewModel.searchText!.lowercased())) &&
                                (kanbanViewModel.taskType == nil || $0.type == kanbanViewModel.taskType) &&
                                (kanbanViewModel.taskPriority == nil || $0.taskPriority == kanbanViewModel.taskPriority) && (($0.isVisible == true) || (showArchived == true))
                            }.sorted(by: { task1, task2 in
                                task1.updated_at > task2.updated_at
                            })) {task in
                                TaskCardView(task: task)
                                    .padding(.horizontal, 10)
//                                    .onTapGesture(count: 2) {
//                                        kanbanViewModel.selectedTask = task
//                                        kanbanViewModel.showEditTaskPopUP.toggle()
//                                    }
                                    .buttonStyle(.plain)
                            }
                        }
                        .scrollIndicators(.never)
                    }
                }
                .frame(minWidth: 135)
            }
            .dropDestination(for: String.self) { items, location in
                kanbanViewModel.currentlyDragging = items.first
                self.disableTap = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.disableTap = false
                }
                withAnimation(.easeIn) {
                    kanbanViewModel.addItem(currentlyDragging: kanbanViewModel.currentlyDragging ?? "", status: TaskStatus.PENDING)
                }
                return false
            } isTargeted: { status in
            }
        }
    }
    
    @ViewBuilder
    func DoneView() -> some View {
        VStack {
            ColumnTitle(status: .DONE, color: Color.theme.greenKanban)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.theme.grayColumn)
                    .padding(.bottom, -10)
                
                NavigationStack {
                    VStack {
                        Spacer()
                            .frame(height: 10)
                        
                        ScrollView(.vertical) {
                            ForEach(kanbanViewModel.localTasks.filter {
                                $0.status == TaskStatus.DONE  &&
                                ( kanbanViewModel.searchText == nil || kanbanViewModel.searchText!.isEmpty || $0.title.lowercased().contains(kanbanViewModel.searchText!.lowercased())) &&
                                (kanbanViewModel.taskType == nil || $0.type == kanbanViewModel.taskType) &&
                                (kanbanViewModel.taskPriority == nil || $0.taskPriority == kanbanViewModel.taskPriority) && (($0.isVisible == true) || (showArchived == true))
                            }.sorted(by: { task1, task2 in
                                task1.updated_at > task2.updated_at
                            })) {task in
                                TaskCardView(task: task)
                                    .padding(.horizontal, 10)
//                                    .onTapGesture(count: 2) {
//                                        kanbanViewModel.selectedTask = task
//                                        kanbanViewModel.showEditTaskPopUP.toggle()
//                                    }
                                    .buttonStyle(.plain)
                            }
                        }
                        .scrollIndicators(.never)
                    }
                }
                .frame(minWidth: 135)
            }
            .dropDestination(for: String.self) { items, location in
                self.disableTap = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.disableTap = false
                }
                if kanbanViewModel.role != Role.PRODUCT_MANAGER {
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
}
