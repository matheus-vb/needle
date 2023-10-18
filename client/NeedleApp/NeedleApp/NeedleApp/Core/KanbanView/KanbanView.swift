//
//  KanbanView.swift
//  NeedleApp
//
//  Created by Jpsmor on 04/08/23.
//

import SwiftUI

struct KanbanView: View {
    @ObservedObject var kanbanViewModel: KanbanViewModel<TaskDataService>
    @State var disableTap : Bool = false
    @State var targetStatus : TaskStatus = .NOT_VISIBLE
    
    init(tasks: [TaskModel], role: Role, selectedColumn: Binding<TaskStatus>, showPopUp: Binding<Bool>, showCard: Binding<Bool>, selectedWorkspace: Workspace, selectedTask: Binding<TaskModel?>, isEditing: Binding<Bool>, isDeleting: Binding<Bool>, isArchiving: Binding<Bool>) {
        
        self.kanbanViewModel = KanbanViewModel(
            localTasks: tasks,
            role: role,
            selectedColumn: selectedColumn,
            showPopUp: showPopUp,
            showCard: showCard,
            selectedWorkspace: selectedWorkspace,
            selectedTask: selectedTask,
            isEditing: isEditing,
            isDeleting: isDeleting,
            isArchiving: isArchiving,
            taskDS: .shared
        )
    }
    
    @State var taskType: TaskType? = nil
    @State var taskPriority: TaskPriority? = nil
    @State var searchText: String? = nil
    @State var showArchived : Bool = false
    
    var body: some View {
        ZStack {
            VStack{
                HStack{
                    HStack {
                        DropdownTypeButton(taskType: $kanbanViewModel.taskType, dropOptions: TaskType.allCases) {}
                        DropdownPriorityButton(taskPriority: $kanbanViewModel.taskPriority, dropOptions: TaskPriority.allCases) {}
                    }.padding(.leading, 8)
                    Spacer()
                    HStack {
                        if showArchived {
                            Image(systemName: "eye")
                                .font(Font.custom("SF Pro", size: 14))
                                .foregroundColor(.black)
                            Text(NSLocalizedString("Ocultar Tasks", comment: ""))
                                .font(Font.custom("SF Pro", size: 14))
                                .underline()
                                .foregroundColor(.black)
                        } else {
                            Image(systemName: "eye.slash")
                                .font(Font.custom("SF Pro", size: 14))
                                .foregroundColor(.black)
                            Text(NSLocalizedString("Mostrar Tasks", comment: ""))
                                .font(Font.custom("SF Pro", size: 14))
                                .underline()
                                .foregroundColor(.black)
                        }
                    }
                    .modifier(Clickable())
                    .onTapGesture {
                        showArchived.toggle()
                    }
                }
                .padding(.top, 32)
                HStack(alignment: .center){
                    Spacer()
                    HStack(spacing: 10) {
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
            .padding(.trailing, 30)
            .padding(.leading, 10)
        }
        .background(Color.theme.grayBackground)
        
    }
}
