//
//  KanbanComponentViewModel.swift
//  Needle
//
//  Created by gabrielfelipo on 01/06/23.
//

import Foundation

class KanbanComponentViewModel: ObservableObject {
    @Published var tasks: [TaskModel] = []
    let taskService = TaskService(baseUrl: _URL)
}
