//
//  TaskDataServiceMock.swift
//  NeedleAppTests
//
//  Created by matheusvb on 30/08/23.
//

import Foundation
import Combine

class TaskDataServiceMock: TaskDataServiceProtocol {
    let db: DBMock
    
    @Published var allUsersTasks: [String : [TaskModel]] = [:]
    var allUsersTasksPublisher: Published<[String : [TaskModel]]>.Publisher { $allUsersTasks }
    
    @Published var queriedTasks: [TaskModel] = []
    var queriedTasksPublihser: Published<[TaskModel]>.Publisher { $queriedTasks }
    
    var currError: NetworkingManager.NetworkingError?
    
    init(db: DBMock) {
        self.db = db
    }
    
    func getWorkspaceTasks(userId: String, workspaceId: String) {
        guard let tasks = db.tasksInWorkspace[workspaceId] else { return }
        
        self.allUsersTasks[workspaceId] = tasks
    }
    
    func createTask(dto: CreateTaskDTO, userId: String, workspaceId: String) {
        guard let status = TaskStatus(rawValue: dto.stats) else { return }
        guard let type = TaskType(rawValue: dto.type) else { return }
        guard let priority = TaskPriority(rawValue: dto.priority) else { return }
        
        db.tasksInWorkspace[workspaceId]!.append(TaskModel(id: "1", title: dto.title, description: dto.description, status: status, type: type, documentId: "1", endDate: dto.endDate, workId: workspaceId, taskPriority: priority, document: nil, user: nil, created_at: "1", updated_at: "1"))
        
        self.getWorkspaceTasks(userId: userId, workspaceId: workspaceId)
    }
    
    func updateTaskStatus(taskId: String, status: TaskStatus, userId: String, workspaceId: String) {
        guard let taskIdx = db.tasksInWorkspace[workspaceId]?.firstIndex(where: { $0.id == taskId }) else { return }
        
        db.tasksInWorkspace[workspaceId]?[taskIdx].status = status
    }
    
    func queryTasks(dto: QueryTasksDTO) {
        if let allTasks = db.tasksInWorkspace[dto.workspaceId] {
            let currTasks = allTasks.filter { task in
                guard task.workId == dto.workspaceId else { return false }
                
                if let query = dto.query, !task.title.contains(query), !task.description.contains(query) { return false }
                if let status = dto.status, task.status != TaskStatus(rawValue: status)! { return false }
                if let area = dto.area, task.type != TaskType(rawValue: area)! { return false }
                if let priority = dto.priority, task.taskPriority != TaskPriority(rawValue: priority)! { return false }
                
                return true
            }
            
            self.queriedTasks = currTasks
        }
        
    }
    
    func saveTask(dto: SaveTaskDTO, userId: String, workspaceId: String) {
        guard let taskIdx = db.tasksInWorkspace[workspaceId]?.firstIndex(where: { $0.id == dto.taskId }) else { return }
        
        var user: User?
        
        if let userId = dto.userId {
            user = db.users.first(where: { $0.id == userId })
        }
        
        db.tasksInWorkspace[workspaceId]![taskIdx] = TaskModel(
            id: dto.taskId,
            title: dto.title,
            description: dto.description,
            status: TaskStatus(rawValue: dto.status)!,
            type: TaskType(rawValue: dto.type)!,
            documentId: dto.documentId,
            endDate: dto.endDate,
            workId: workspaceId,
            taskPriority: TaskPriority(rawValue: dto.priority)!,
            document: nil,
            user: user,
            created_at: "",
            updated_at: ""
        )
        
        self.getWorkspaceTasks(userId: userId, workspaceId: workspaceId)
    }
    
    func deleteTask(dto: DeleteTaskDTO, userId: String, workspaceId: String) {
        guard let taskIdx = db.tasksInWorkspace[workspaceId]?.firstIndex(where: { $0.id == dto.taskId }) else { return }
        
        db.tasksInWorkspace[workspaceId]!.remove(at: taskIdx)
        
        self.getWorkspaceTasks(userId: userId, workspaceId: workspaceId)
    }
}
