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
    @State private var filteredType = ""
    @State private var filteredStatus = ""
    @State private var filteredPriority = ""
    @State private var sortByTaskName = true
    @State private var sortByPriority = false
    @State private var sortByUpdate = false
    @State private var sortByUserName = false
    @State private var sortByType = false
    
    private func dateIsInRange(_ dateString: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dateString) {
            return date >= startDate && date <= endDate
        }
        return false
    }
    
    let options: [OptionItem] = [
        OptionItem(title: "Option 1", color: .blue),
        OptionItem(title: "Option 2", color: .green),
        OptionItem(title: "Option 3", color: .purple),
    ]
    
    @State private var selectedOption: OptionItem = OptionItem(title: "Option 1", color: .blue)
    
    
    var body: some View {
        VStack {
            HStack(){
                Circle()
                    .fill(Color.red)
                    .frame(width: 12, height: 12)
                Text("Pendente")
                    .font(.system(size: 18, weight: .regular))
                Circle()
                    .fill(Color.green)
                    .frame(width: 12, height: 12)
                Text("Revisado")
                    .font(.system(size: 18, weight: .regular))
                Spacer()
            }
            
            HStack {
                Group{
                    Picker("Status", selection: $searchDocumentsViewModel.selectedStatus) {
                        ForEach(TaskStatus.allCases, id: \.self) { status in
                            Text(status.displayName)
                                .foregroundColor(Color.theme.blackMain)
                                .tag(status as TaskStatus?)
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(width: 160)
                    Button(action: {
                        searchDocumentsViewModel.selectedStatus = nil
                    }, label: {
                        Image(systemName: "arrow.counterclockwise")
                    })
                    .buttonStyle(.plain)
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
                    Picker("Área", selection: $searchDocumentsViewModel.selectedArea) {
                        ForEach(TaskType.allCases, id: \.self) { area in
                            Text(area.displayName)
                                .foregroundColor(Color.theme.blackMain)
                                .tag(area as TaskType?)
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(width: 160)
                    Button(action: {
                        searchDocumentsViewModel.selectedArea = nil
                    }, label: {
                        Image(systemName: "arrow.counterclockwise")
                    })
                    .buttonStyle(.plain)
                }
                
                Spacer()
                
                Group{
                    Picker("Prioridade", selection: $searchDocumentsViewModel.selectedPriority) {
                        ForEach(TaskPriority.allCases, id: \.self) { priority in
                            Text(priority.displayName)
                                .foregroundColor(Color.theme.blackMain)
                                .tag(priority as TaskPriority?)
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(width: 160)
                    Button(action: {
                        searchDocumentsViewModel.selectedPriority = nil
                    }, label: {
                        Image(systemName: "arrow.counterclockwise")
                    })
                    .buttonStyle(.plain)
                }
                
                Spacer()
                
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
            .padding(.horizontal)
            .padding(.top, 10)
            
            Table(searchDocumentsViewModel.tasks, sortOrder: $sortOrder){
                TableColumn("Nome da Task 􀄬", value: \.title)
                TableColumn("Prioridade 􀄬", value: \.taskPriority.codingKey.stringValue )
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
