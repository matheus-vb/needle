//
//  SearchDocuments.swift
//  NeedleApp
//
//  Created by vivi on 26/07/23.
//

import SwiftUI


struct SearchDocuments: View {
    
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
    
    @State var tasks: [TaskModel] = [
        TaskModel(
            id:"00",
            title: "Document 1",
            description: "abcdefg",
            status: "Pendente",
            type: "Design",
            documentId: "Matheus",
            endDate: "2023-07-31",
            workId: "Batata",
            userId: "hVivi",
            taskPriority: TaskPriority(rawValue: "HIGH")!,
            document: nil,
            user: nil
        ),
        TaskModel(
            id:"01",
            title: "Document 2",
            description: "abcdefg",
            status: "Pendente",
            type: "Development",
            documentId: "Bibia",
            endDate: "2023-07-31",
            workId: "Batata",
            userId: "fVivi",
            taskPriority: TaskPriority(rawValue: "HIGH")!,
            document: nil,
            user: nil
        ),
        TaskModel(
            id:"02",
            title: "Document 3",
            description: "abcdefg",
            status: "Pendente",
            type: "Design",
            documentId: "Vivi",
            endDate: "2023-07-31",
            workId: "Batata",
            userId: "aaVivi",
            taskPriority: TaskPriority(rawValue: "HIGH")!,
            document: nil,
            user: nil
        ),
        TaskModel(
            id:"03",
            title: "Document 4",
            description: "abcdefg",
            status: "Pendente",
            type: "Design",
            documentId: "Laurinha",
            endDate: "2023-07-31",
            workId: "Batata",
            userId: "eVivi",
            taskPriority: TaskPriority(rawValue: "HIGH")!,
            document: nil,
            user: nil

        ),
        TaskModel(
            id:"04",
            title: "Document 5",
            description: "abcdefg",
            status: "Pendente",
            type: "Design",
            documentId: "André",
            endDate: "2023-07-31",
            workId: "Batata",
            userId: "dVivi",
            taskPriority: TaskPriority(rawValue: "HIGH")!,
            document: nil,
            user: nil
        ),
        TaskModel(
            id:"05",
            title: "Document 6",
            description: "abcdefg",
            status: "Pendente",
            type: "Design",
            documentId: "Medeiros",
            endDate: "2023-07-31",
            workId: "Batata",
            userId: "cVivi",
            taskPriority: TaskPriority(rawValue: "HIGH")!,
            document: nil,
            user: nil

        ),
        TaskModel(
            id:"06",
            title: "Document 7",
            description: "abcdefg",
            status: "Pendente",
            type: "Design",
            documentId: "Naval",
            endDate: "2023-07-31",
            workId: "Batata",
            userId: "aVivi",
            taskPriority: TaskPriority(rawValue: "HIGH")!,
            document: nil,
            user: nil
        ),
        
    ]
    
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
            
            Table(tasks, sortOrder: $sortOrder){
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
                tasks.sort(using: $0)
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
