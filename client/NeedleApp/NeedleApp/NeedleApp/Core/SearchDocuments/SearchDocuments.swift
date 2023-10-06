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
    @State var scrollToOne = 0
    @State var scrollToTwo = 0
    
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
        HStack{
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
                                        if self.scrollToOne > 0 {
                                            self.scrollToOne -= 3
                                            if self.scrollToOne < 0 {
                                                self.scrollToOne = 0
                                            }
                                        }
                                        withAnimation {
                                            value.scrollTo(scrollToOne)
                                        }
                                    } label: {
                                        Image(systemName: "chevron.left")
                                            .padding()
                                            .foregroundColor(scrollToOne <= 0 ? Color.theme.grayPressed : Color.theme.blackMain)
                                    }
                                    .buttonStyle(.plain)
                                    
                                    Button {
                                        if self.scrollToOne < searchDocumentsViewModel.userTasks.count {
                                            self.scrollToOne += 3
                                            if self.scrollToOne > searchDocumentsViewModel.userTasks.count - 1{
                                                self.scrollToOne = searchDocumentsViewModel.userTasks.count - 1
                                            }
                                            
                                        }
                                        
                                        withAnimation {
                                            value.scrollTo(scrollToOne)
                                        }
                                    } label: {
                                        Image(systemName: "chevron.right")
                                            .padding()
                                            .foregroundColor(scrollToOne >= searchDocumentsViewModel.userTasks.count - 1 ? Color.theme.grayPressed : Color.theme.blackMain)
                                        
                                    }
                                    .buttonStyle(.plain)
                                }
                                
                                ScrollView(.horizontal, showsIndicators: false){
                                    LazyHStack(spacing: 32) {
                                        ForEach(0..<searchDocumentsViewModel.userTasks.count, id: \.self){ i in
                                            
                                            DocumentationThumbnailView(task: self.searchDocumentsViewModel.userTasks[i], showDate: true)
                                                .id(i)
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
                                        if self.scrollToTwo > 0 {
                                            self.scrollToTwo -= 3
                                            if self.scrollToTwo < 0 {
                                                self.scrollToTwo = 0
                                            }
                                        }
                                        withAnimation {
                                            value.scrollTo(scrollToTwo, anchor: .center)
                                        }
                                    } label: {
                                        Image(systemName: "chevron.left")
                                            .padding()
                                            .foregroundColor(scrollToTwo <= 0 ? Color.theme.grayPressed : Color.theme.blackMain)
                                    }
                                    .buttonStyle(.plain)
                                    
                                    Button {
                                        if self.scrollToTwo < searchDocumentsViewModel.tasks.count - 1 {
                                            self.scrollToTwo += 3
                                            if self.scrollToTwo > searchDocumentsViewModel.tasks.count - 1 {
                                                self.scrollToTwo = searchDocumentsViewModel.tasks.count - 1
                                            }
                                        }
                                        withAnimation {
                                            value.scrollTo(scrollToTwo, anchor: .center)
                                        }
                                    } label: {
                                        Image(systemName: "chevron.right")
                                            .padding()
                                            .foregroundColor(scrollToTwo >= searchDocumentsViewModel.tasks.count - 1 ? Color.theme.grayPressed : Color.theme.blackMain)
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
                                }.padding(.bottom, 50)
                            }
                        }
                        
                    }
                }
                .padding(.top, 50)
            }
            .padding(.top, 32)
            .padding(.leading, 64)
            .padding(.trailing, 64)
        
            Divider()
            DocumentationViewSideBarUIView()
        }
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
