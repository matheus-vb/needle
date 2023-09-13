//
//  SearchDocuments.swift
//  NeedleApp
//
//  Created by vivi on 26/07/23.
//

import SwiftUI


struct SearchDocuments: View {
    
    @ObservedObject var searchDocumentsViewModel: SearchDocumentsViewModel<TaskDataService>
    
    init(tasks: [TaskModel]?, workspaceId: String, selectedTask: Binding<TaskModel?>, isEditing: Binding<Bool>) {
        
        self.searchDocumentsViewModel = SearchDocumentsViewModel(
            tasks: tasks ?? [],
            workspaceId: workspaceId,
            selectedTask: selectedTask,
            isEditing: isEditing,
            taskDS: TaskDataService.shared
        )
    }
    
    var body: some View {
        VStack {
            
            HStack(spacing: 16) {
                DropdownStatusButton(taskStatus: $searchDocumentsViewModel.selectedStatus, dropOptions: TaskStatus.allCases){

                }
                
                DropdownTypeButton(taskType: $searchDocumentsViewModel.selectedArea, dropOptions: TaskType.allCases) {
                    
                }
                
                DropdownPriorityButton(taskPriority: $searchDocumentsViewModel.selectedPriority, dropOptions: TaskPriority.allCases) {
                    
                }

                Spacer()
                //TODO: Add date to query
                
                Group {
                    TextField(NSLocalizedString("Procurar por nome, descrição, responsável...", comment: ""), text: $searchDocumentsViewModel.query ?? "")
                        .frame(width: 320, height: 32)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onSubmit {
                            searchDocumentsViewModel.query = nil
                        }
                        .modifier(searchFieldModifier())
                    Button(action: {
                        searchDocumentsViewModel.query = nil
                    }, label: {
                        Image(systemName: "delete.left")
                    })
                    .buttonStyle(.plain)
                }
            }
            .padding(.top, 10)
            
            Table(searchDocumentsViewModel.tasks, selection: $searchDocumentsViewModel.selectedTaskID, sortOrder: $searchDocumentsViewModel.sortOrder){
                TableColumn(NSLocalizedString("Nome da Task", comment: ""), value: \.title)
                TableColumn(NSLocalizedString("Prioridade", comment: ""), value: \.taskPriority.order ){
                    switch $0.taskPriority{
                    case .LOW:
                        Text($0.taskPriority.displayName)
                            .foregroundColor(Color.theme.greenKanban)
                    case .MEDIUM:
                        Text($0.taskPriority.displayName)
                            .foregroundColor(Color.theme.orangeKanban)
                    case .HIGH:
                        Text($0.taskPriority.displayName)
                            .foregroundColor(Color.theme.redMain)
                    case .VERY_HIGH:
                        Text($0.taskPriority.displayName)
                            .foregroundColor(Color.theme.redMain)
                    }
                }
                TableColumn( NSLocalizedString("Status", comment: ""), value: \.status.order){
                    Text($0.status.displayName)
                        .foregroundColor(getColor(task: $0))
                }
                TableColumn( NSLocalizedString("Área", comment: ""), value: \.type.displayName)
                TableColumn( NSLocalizedString("Responsável", comment: "")) {
                    Text($0.user?.name ?? NSLocalizedString("Sem responsável.", comment: ""))
                }
                TableColumn( NSLocalizedString("Atualização", comment: ""), value: \.updated_at) {
                    Text(HandleDate.formatDateWithTime(dateInput: $0.updated_at))
                }
            }
            .contextMenu(forSelectionType: TaskModel.ID.self) { _ in } primaryAction: { items in
                guard let task = searchDocumentsViewModel.tasks.first(where: { $0.id == items.first }) else { return }
                searchDocumentsViewModel.selectedTask = task
                searchDocumentsViewModel.isEditing = true
            }
            .onChange(of: searchDocumentsViewModel.sortOrder){
                searchDocumentsViewModel.tasks.sort(using: $0)
            }
            .cornerRadius(6)
            .padding(.top, 20)
            .padding(.bottom, 60)
            
            Spacer()
        }
        .padding(.top, 32)
        .padding(.leading, 64)
        .padding(.trailing, 64)
    }
}

extension SearchDocuments {
    @ViewBuilder
    func SearchTitleLabel(rowName: String, color: Color) -> some View {
        
        HStack{
            Circle()
                .frame(width: 10)
                .foregroundColor(color)
                .cornerRadius(5)
            Spacer()
                .frame(width: 8)
            Text(rowName)
                .font(
                    Font.custom("SF Pro", size: 18)
                        .weight(.medium)
                )
                .foregroundColor(.black)
            Spacer()
        }
        .frame(minWidth: 132)
        .frame(height: 32)
        .cornerRadius(5)
        
    }
    
    func getColor(task: TaskModel) -> Color {
        switch task.status {
        case TaskStatus.DONE: return Color.theme.greenKanban
        case TaskStatus.IN_PROGRESS: return Color.theme.blueKanban
        case TaskStatus.TODO: return Color.theme.redMain
        case TaskStatus.PENDING: return Color.theme.orangeKanban
        default: return Color.theme.blackMain
        }
    }
}
