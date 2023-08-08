//
//  KanbanViewModel.swift
//  NeedleApp
//
//  Created by matheusvb on 04/08/23.
//

import Foundation

class KanbanViewModel: ObservableObject {
    @Published var localTasks: [TaskModel]
    
    init(localTasks: [TaskModel]) {
        self.localTasks = localTasks
    }
}
