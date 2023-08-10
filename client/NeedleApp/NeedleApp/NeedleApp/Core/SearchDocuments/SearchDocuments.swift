//
//  SearchDocuments.swift
//  NeedleApp
//
//  Created by vivi on 26/07/23.
//

import SwiftUI


struct SearchDocuments: View {
    
    @EnvironmentObject var searchDocumentsViewModel: SearchDocumentsViewModel
    
    @State private var searchText = ""
    @State private var sortOrder = [KeyPathComparator(\TaskModel.title)]
    @State private var sortByStatus = false
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var filteredType = "Área"
    @State private var filteredStatus = "Status"
    @State private var filteredPriority = "Prioridade"
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
            HStack(){
                Circle()
                    .fill(Color.theme.redMain)
                    .frame(width: 12, height: 12)
                Text("Pendente")
                    .font(.system(size: 18, weight: .regular))
                Circle()
                    .fill(Color.theme.greenKanban)
                    .frame(width: 12, height: 12)
                Text("Revisado")
                    .font(.system(size: 18, weight: .regular))
                Spacer()
            }
            
            HStack(spacing: 16) {
//                Group{
//                    Picker("Status", selection: $searchDocumentsViewModel.selectedStatus) {
//                        ForEach(TaskStatus.allCases, id: \.self) { status in
//                            Text(status.displayName)
//                                .foregroundColor(Color.theme.blackMain)
//                                .tag(status as TaskStatus?)
//                        }
//                    }
//                    .pickerStyle(.menu)
//                    .frame(width: 160)
//                    Button(action: {
//                        searchDocumentsViewModel.selectedStatus = nil
//                    }, label: {
//                        Image(systemName: "arrow.counterclockwise")
//                    })
//                    .buttonStyle(.plain)
//                }
               
                DropdownStatusButton(taskStatus: $searchDocumentsViewModel.selectedStatus, dropOptions: TaskStatus.allCases){

                }
                
                DropdownTypeButton(taskType: $searchDocumentsViewModel.selectedArea, dropOptions: TaskType.allCases) {
                    
                }
                
                DropdownPriorityButton(taskPriority: $searchDocumentsViewModel.selectedPriority, dropOptions: TaskPriority.allCases) {
                    
                }

                Spacer()
                //TODO: Add date to query
//                VStack {
//                    DatePicker("Start Date", selection: $startDate, in: ...endDate, displayedComponents: .date)
//                        .labelsHidden()
//                        .frame(width: 100)
//                    DatePicker("End Date", selection: $endDate, in: startDate...Date(), displayedComponents: .date)
//                        .labelsHidden()
//                        .frame(width: 100)
//                }
//                .padding(.horizontal)
                
                Group {
                    TextField("Procurar por nome, descrição, responsável...", text: $searchDocumentsViewModel.query ?? "")
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 320)
                    Button(action: {
                        searchDocumentsViewModel.query = nil
                    }, label: {
                        Image(systemName: "arrow.counterclockwise")
                    })
                    .buttonStyle(.plain)
                }
            }
            .padding(.top, 10)
            
            Table(searchDocumentsViewModel.tasks, sortOrder: $sortOrder){
                TableColumn("Nome da Task 􀄬", value: \.title)
                TableColumn("Prioridade 􀄬", value: \.taskPriority.codingKey.stringValue ){
                    switch $0.taskPriority{
                    case .LOW:
                        Text("\($0.taskPriority.codingKey.stringValue) 􀋊")
                            .foregroundColor(Color.theme.greenKanban)
                    case .MEDIUM:
                        Text("\($0.taskPriority.codingKey.stringValue) 􀋊")
                            .foregroundColor(Color.theme.orangeKanban)
                    case .HIGH:
                        Text("\($0.taskPriority.codingKey.stringValue) 􀋊")
                            .foregroundColor(Color.theme.redMain)
                    case .VERY_HIGH:
                        Text("\($0.taskPriority.codingKey.stringValue) 􀋊")
                            .foregroundColor(Color.theme.redMain)
                    }
                }
                TableColumn("Status 􀄬"){
                    Circle()
                        .fill($0.status == TaskStatus.DONE.rawValue ? Color.green : Color.red)
                        .frame(width: 12, height: 12)
                }
                TableColumn("Área 􀄬", value: \.type)
                TableColumn("Responsável") {
                    Text($0.user?.name ?? "Sem responsável.")
                }
                TableColumn("Atualização 􀄬", value: \.endDate)
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
