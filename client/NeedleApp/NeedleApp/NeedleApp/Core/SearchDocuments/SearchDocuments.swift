//
//  SearchDocuments.swift
//  NeedleApp
//
//  Created by vivi on 26/07/23.
//

import SwiftUI


struct SearchDocuments: View {
    
    @ObservedObject var searchDocumentsViewModel: SearchDocumentsViewModel<TaskDataService>
    @State var seeDocumentation : Bool = false
    @State var scrollOffset : Int = 0

    
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
                
                DropdownTypeButton(taskType: $searchDocumentsViewModel.selectedArea, dropOptions: TaskType.allCases) {
                }
                
                DropdownPriorityButton(taskPriority: $searchDocumentsViewModel.selectedPriority, dropOptions: TaskPriority.allCases) {
                    
                }
                
                Spacer()
                //TODO: Add date to query
                
                CustomSearchBarView(text: $searchDocumentsViewModel.query)
            }
            .padding(.top, 10)
            ScrollView(.vertical){
                VStack (alignment: .leading, spacing: 50){
                    ScrollViewReader { value in
                        VStack(alignment: .leading, spacing: 16){
                            HStack{
                                Text(NSLocalizedString("Último acesso", comment: ""))
                                    .font(.custom("SF Pro", size: 18)
                                        .weight(.bold))
                                Spacer()
                                
                                Button {
                                    value.scrollTo(0)
                                    print("ho")
                                } label: {
                                    Image(systemName: "chevron.left")
                                        .padding()
                                }
                                .buttonStyle(.plain)

                                Button {
                                    scrollOffset += 1
                                    value.scrollTo(8)
                                    print("hey")
                                } label: {
                                    Image(systemName: "chevron.right")
                                        .padding()
                                }
                                .buttonStyle(.plain)

                            }
                            
                            ScrollView(.horizontal, showsIndicators: false){
                                LazyHStack(spacing: 32) {
                                    ForEach(0..<searchDocumentsViewModel.tasks.count, id: \.self){ i in
                                        DocumentationThumbnailView(taskTitle: "\(self.searchDocumentsViewModel.tasks[i].isRejected)", taskOwner: self.searchDocumentsViewModel.tasks[i].user?.name ?? "Sem responsável", taskContent: self.searchDocumentsViewModel.tasks[i].document?.textString ?? "", isRejected: self.searchDocumentsViewModel.tasks[i].isRejected, status: self.searchDocumentsViewModel.tasks[i].status)
                                            .id(i)
                                    }
                                }
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 16){
                        Text(NSLocalizedString("A revisar", comment: ""))
                            .font(.custom("SF Pro", size: 18)
                                .weight(.bold))
                        ScrollView(.horizontal, showsIndicators: false){
                            LazyHStack(spacing: 32) {
                            }
                        }
                    }
                    VStack(alignment: .leading, spacing: 16){
                        Text(NSLocalizedString("Todas as documentações", comment: ""))
                            .font(.custom("SF Pro", size: 18)
                                .weight(.bold))
                        ScrollView(.horizontal, showsIndicators: false){
                            LazyHStack(spacing: 32) {
                            }
                        }
                    }
                }
            }
            .padding(.top, 50)
            
            //            Table(searchDocumentsViewModel.tasks, selection: $searchDocumentsViewModel.selectedTaskID, sortOrder: $searchDocumentsViewModel.sortOrder){
            //                TableColumn(NSLocalizedString("Nome da Task", comment: ""), value: \.title)
            //                TableColumn(NSLocalizedString("Prioridade", comment: ""), value: \.taskPriority.order ){
            //                    switch $0.taskPriority{
            //                    case .LOW:
            //                        Text($0.taskPriority.displayName)
            //                            .foregroundColor(Color.theme.greenKanban)
            //                    case .MEDIUM:
            //                        Text($0.taskPriority.displayName)
            //                            .foregroundColor(Color.theme.orangeKanban)
            //                    case .HIGH:
            //                        Text($0.taskPriority.displayName)
            //                            .foregroundColor(Color.theme.redMain)
            //                    case .VERY_HIGH:
            //                        Text($0.taskPriority.displayName)
            //                            .foregroundColor(Color.theme.redMain)
            //                    }
            //                }
            //                TableColumn( NSLocalizedString("Status", comment: ""), value: \.status.order){
            //                    Text($0.status.displayName)
            //                        .foregroundColor(getColor(task: $0))
            //                }
            //                TableColumn( NSLocalizedString("Área", comment: ""), value: \.type.displayName)
            //                TableColumn( NSLocalizedString("Responsável", comment: "")) {
            //                    Text($0.user?.name ?? NSLocalizedString("Sem responsável.", comment: ""))
            //                }
            //                TableColumn( NSLocalizedString("Atualização", comment: ""), value: \.updated_at) {
            //                    Text(HandleDate.formatDateWithTime(dateInput: $0.updated_at))
            //                }
            //            }
            //            .contextMenu(forSelectionType: TaskModel.ID.self) { _ in } primaryAction: { items in
            //                guard let task = searchDocumentsViewModel.tasks.first(where: { $0.id == items.first }) else { return }
            //                searchDocumentsViewModel.selectedTask = task
            //                searchDocumentsViewModel.isEditing = true
            //            }
            //            .onChange(of: searchDocumentsViewModel.sortOrder){
            //                searchDocumentsViewModel.tasks.sort(using: $0)
            //            }
            //            .cornerRadius(6)
            //            .padding(.top, 20)
            //            .padding(.bottom, 60)
            
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
