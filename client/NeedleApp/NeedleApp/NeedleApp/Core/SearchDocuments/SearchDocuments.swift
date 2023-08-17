//
//  SearchDocuments.swift
//  NeedleApp
//
//  Created by vivi on 26/07/23.
//

import SwiftUI


struct SearchDocuments: View {
    
    @EnvironmentObject var searchDocumentsViewModel: SearchDocumentsViewModel
    
    @EnvironmentObject var projectViewModel: ProjectViewModel
    
    @State private var searchText = ""
    @State private var sortOrder = [KeyPathComparator(\TaskModel.title)]
    @State private var sortByStatus = false
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var sortByTaskName = true
    @State private var sortByPriority = false
    @State private var sortByUpdate = false
    @State private var sortByUserName = false
    @State private var sortByType = false
    @State private var dateIsPresented = false
    
    @State private var mydate = "Data"
    
    private func dateIsInRange(_ dateString: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dateString) {
            return date >= startDate && date <= endDate
        }
        return false
    }

    
    var body: some View {
        VStack {
            
            HStack(spacing: 16) {
                DropdownStatusButton(taskStatus: $searchDocumentsViewModel.selectedStatus, dropOptions: TaskStatus.allCases){}
                DropdownTypeButton(taskType: $searchDocumentsViewModel.selectedArea, dropOptions: TaskType.allCases) {}
                DropdownPriorityButton(taskPriority: $searchDocumentsViewModel.selectedPriority, dropOptions: TaskPriority.allCases) {}

                Spacer()
                
                Group {
                    TextField("Procurar por nome, descrição, responsável...", text: $searchDocumentsViewModel.query ?? "")
                        .frame(width: 320, height: 32)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onSubmit {
                            searchDocumentsViewModel.query = nil
                        }
                    Button(action: {
                        searchDocumentsViewModel.query = nil
                    }, label: {
                        Image(systemName: "arrow.counterclockwise")
                    })
                    .buttonStyle(.plain)
                }
            }
            .padding(.top, 10)
            
            Table(searchDocumentsViewModel.tasks, selection: $searchDocumentsViewModel.selectedTask, sortOrder: $sortOrder){
                TableColumn("Nome da Task", value: \.title)
                TableColumn("Prioridade", value: \.taskPriority.order ){
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
                TableColumn("Status", value: \.status.order){
                    Text($0.status.displayName)
                        .foregroundColor(getColor(task: $0))
                }
                TableColumn("Área", value: \.type.displayName)
                TableColumn("Responsável") {
                    Text($0.user?.name ?? "Sem responsável.")
                }
                TableColumn("Atualização", value: \.endDate)
            }
            .contextMenu(forSelectionType: TaskModel.ID.self) { _ in } primaryAction: { items in
                guard let task = searchDocumentsViewModel.tasks.first(where: { $0.id == items.first }) else { return }
                projectViewModel.selectedTask = task
                projectViewModel.showEditTaskPopUP = true
            }
            .onChange(of: sortOrder){
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
