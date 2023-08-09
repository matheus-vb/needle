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
            
            HStack {
                
                DropdownButton(text: $filteredStatus, dropOptions: TaskStatus.allCases.map{$0.rawValue}){
                }
                
                DropdownDateButton(text: $mydate, dropOptions: []){
                    dateIsPresented.toggle()
                }.popover(isPresented: $dateIsPresented, arrowEdge: .bottom) {
                    VStack{
                        HStack{
                            Text("Início: ")
                            DatePicker("Start Date", selection: $startDate, in: ...endDate, displayedComponents: .date)
                                .labelsHidden()
                                .frame(width: 100)
                        }
                            HStack{
                                Text("Fim: ")
                                DatePicker("End Date", selection: $endDate, in: startDate...Date(), displayedComponents: .date)
                                    .labelsHidden()
                                    .frame(width: 100)
                            }
                        
                    }
                    .padding()
                    .background(Color.theme.greenSecondary)
                }
                            
                DropdownButton(text: $filteredType, dropOptions: TaskType.allCases.map{$0.rawValue}){
                }
                
                DropdownButton(text: $filteredPriority, dropOptions: TaskPriority.allCases.map{$0.rawValue}){
                }
                
                Spacer()
                
                HStack (spacing: 0){
                    TextField("Search", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 280)
                    
                    Button {
                        print("Search: \(searchText)")
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .imageScale(.large)
                            .foregroundColor(Color.theme.blackMain)
                    }
                    .padding(.trailing)
                }
                
            }
//            .padding(.horizontal)
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
                    Text("Status: 􀀁")
                        .foregroundColor($0.status == "DONE" ? Color.theme.greenKanban : Color.theme.redMain)
                }
                TableColumn("Área 􀄬", value: \.type)
                TableColumn("Atualização 􀄬"){
                    Text(String($0.endDate.prefix(10)))
                }
                TableColumn("Nome de Usuário 􀄬"){
                    Text(String($0.user?.name.codingKey.stringValue ?? "Usuário"))
                }
            }
            .onChange(of: sortOrder){
                searchDocumentsViewModel.tasks.sort(using: $0)
            }
            .frame(height: 240)
            .cornerRadius(6)
            
            Spacer()
        }
        .padding(.top, 32)
        .padding(.leading, 64)
        .padding(.trailing, 64)
    }
}
