//
//  SearchDocumentsViewModel.swift
//  NeedleApp
//
//  Created by matheusvb on 08/08/23.
//

import Foundation
import Combine

class SearchDocumentsViewModel: ObservableObject {
    let workspaceId: String
    
    @Published var tasks: [TaskModel]
    
    @Published var selectedTask: TaskModel.ID?
    
    @Published var selectedStatus: TaskStatus? = nil
    @Published var selectedArea: TaskType? = nil
    @Published var selectedPriority: TaskPriority? = nil
    @Published var query: String? = nil
    
    @Published var currDTO: QueryTasksDTO
    
    private var tasksDS = TaskDataService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init(tasks: [TaskModel], workspaceId: String) {
        self.tasks = tasks
        self.workspaceId = workspaceId
        
        self.currDTO = QueryTasksDTO(
            workspaceId: workspaceId,
            query: nil,
            status: nil,
            area: nil,
            priority: nil
        )
        
        addSubscribers()
        setupBindings()
        
        TaskDataService.shared.queryTasks(dto: currDTO)
    }
    
    private func addSubscribers() {
        tasksDS.$queriedTasks
            .sink(receiveValue: { [weak self] returnedTasks in
                self?.tasks = returnedTasks
            })
            .store(in: &cancellables)
    }
    
    private func setupBindings() {
        Publishers.CombineLatest4($query, $selectedStatus, $selectedArea, $selectedPriority)
            .sink(receiveValue: { [weak self] (query, selectedStatus, selectedArea, selectedPriority) in
                self?.currDTO = QueryTasksDTO(
                    workspaceId: self!.workspaceId,
                    query: query,
                    status: selectedStatus?.rawValue,
                    area: selectedArea?.rawValue,
                    priority: selectedPriority?.rawValue
                )
                
                TaskDataService.shared.queryTasks(dto: self!.currDTO)
            })
            .store(in: &cancellables)
    }
}
