//
//  InformationPageViewModel.swift
//  NeedleApp
//
//  Created by aaav on 04/09/23.

import Foundation
import Combine
import SwiftUI

class InformationPageViewModel<T: TaskDataServiceProtocol & ObservableObject>: ObservableObject {
    let workspaceId: String
    @Published var tasks: [TaskModel]
    @Published var selectedTaskID: TaskModel.ID?
    @Binding var selectedTask: TaskModel?
    @Binding var isEditing: Bool
    @Published var selectedStatus: TaskStatus? = nil
    @Published var selectedArea: TaskType? = nil
    @Published var selectedPriority: TaskPriority? = nil
    @Published var query: String? = nil
    @Published var currDTO: QueryTasksDTO
    @Published var sortOrder = [KeyPathComparator(\TaskModel.title)]
    
    private var taskDS: T
    private var cancellables = Set<AnyCancellable>()
    
    init(tasks: [TaskModel], workspaceId: String, selectedTask: Binding<TaskModel?>, isEditing: Binding<Bool>, taskDS: T) {
        self.taskDS = taskDS
        self.tasks = tasks
        self.workspaceId = workspaceId
        self.currDTO = QueryTasksDTO(
            workspaceId: workspaceId,
            query: nil,
            status: nil,
            area: nil,
            priority: nil
        )
        self._selectedTask = selectedTask
        self._isEditing = isEditing
        
        addSubscribers()
        setupBindings()
        
        TaskDataService.shared.queryTasks(dto: currDTO)
    }
    
    private func addSubscribers() {
        taskDS.queriedTasksPublihser
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
