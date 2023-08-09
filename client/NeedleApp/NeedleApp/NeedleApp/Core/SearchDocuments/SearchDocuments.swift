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
                PickerApp(selectedOption: selectedOption, options: options)
                    .padding()
                Picker(selection: $filteredStatus, label: Text("Status")){
                    Text("Pendente").tag("pendente")
                    Text("Revisado").tag("revisado")
                }.pickerStyle(.menu)
                    .frame(width: 160)
                VStack {
                    DatePicker("Start Date", selection: $startDate, in: ...endDate, displayedComponents: .date)
                        .labelsHidden()
                        .frame(width: 100)
                    DatePicker("End Date", selection: $endDate, in: startDate...Date(), displayedComponents: .date)
                        .labelsHidden()
                        .frame(width: 100)
                }
                .padding(.horizontal)
                
                Picker(selection: $filteredType, label: Text("Área")) {
                    Text("Inovação").tag("Inovação")
                    Text("Design").tag("Design")
                    Text("Development").tag("Development")
                }
                .pickerStyle(.menu)
                .frame(width: 160)
                
                Picker(selection: $filteredPriority, label: Text("Prioridade")) {
                    Text("Alta").tag("Alta")
                    Text("Média").tag("Média")
                    Text("Baixa").tag("Baixa")
                }
                .pickerStyle(.menu)
                .frame(width: 160)
                
                TextField("Search", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 280)
                
                Button(action: {
                    // call an API with searchText
                    print("Search: \(searchText)")
                }) {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.large)
                        .background(Color("main-green"))
                }
                .padding(.trailing)
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            Table(searchDocumentsViewModel.tasks, sortOrder: $sortOrder){
                TableColumn("Nome da Task 􀄬", value: \.title)
                TableColumn("Prioridade 􀄬", value: \.taskPriority.codingKey.stringValue )
                TableColumn("Status 􀄬"){
                    Circle()
                        .fill($0.status == "Pendente" ? Color.red : Color.green)
                        .frame(width: 12, height: 12)
                }
                TableColumn("Área 􀄬", value: \.type)
                TableColumn("Atualização 􀄬", value: \.endDate)
//                TableColumn("Nome de Usuário 􀄬", value: \.userId?.codingKey.stringValue)du
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
