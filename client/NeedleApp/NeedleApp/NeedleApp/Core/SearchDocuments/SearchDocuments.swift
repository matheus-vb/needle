//
//  SearchDocuments.swift
//  NeedleApp
//
//  Created by vivi on 26/07/23.
//

import SwiftUI


struct SearchDocuments: View {
    
    @ObservedObject var searchDocumentsViewModel: SearchDocumentsViewModel<TaskDataService, AuthenticationManager>
    @State var seeDocumentation : Bool = false
    
    init(tasks: [TaskModel]?, workspaceId: String, selectedTask: Binding<TaskModel?>, isEditing: Binding<Bool>) {
        
        self.searchDocumentsViewModel = SearchDocumentsViewModel(
            tasks: tasks ?? [],
            workspaceId: workspaceId,
            selectedTask: selectedTask,
            isEditing: isEditing,
            taskDS: TaskDataService.shared,
            authManager: AuthenticationManager.shared
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
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false){
                                LazyHStack(spacing: 32) {
                                    ForEach(0..<min(searchDocumentsViewModel.tasks.count, 3), id: \.self){ i in
                                
                                        DocumentationThumbnailView(
                                            task: HandleDate.sortArrayOfDates(dateArr: searchDocumentsViewModel.tasks)[i], showDate: false)
                                            .id(i)
                                    }
                                }
                            }
                        }
                    }
                    ScrollViewReader { value in
                        VStack(alignment: .leading, spacing: 16){
                            HStack{
                                Text(NSLocalizedString("Minha documentação", comment: ""))
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
                                        
                                        if self.searchDocumentsViewModel.tasks[i].user?.id == self.searchDocumentsViewModel.getUserID() {
                                            
                                            DocumentationThumbnailView(task: self.searchDocumentsViewModel.tasks[i], showDate: true)
                                                .id(i)
                                        }

                                    }
                                }
                            }
                        }
                    }
                    ScrollViewReader { value in
                        VStack(alignment: .leading, spacing: 16){
                            HStack{
                                Text(NSLocalizedString("Todas as documentações", comment: ""))
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
                                        DocumentationThumbnailView(task: self.searchDocumentsViewModel.tasks[i], showDate: false)
                                            .id(i)
                                    }
                                }
                            }
                        }
                    }

                }
            }
            .padding(.top, 50)
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
