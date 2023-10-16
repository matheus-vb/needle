//
//  TaskDataServiceProtocol.swift
//  NeedleApp
//
//  Created by matheusvb on 18/08/23.
//

import Foundation

protocol TaskDataServiceProtocol: ObservableObject {
    var allUsersTasks: [String: [TaskModel]] { get set }
    var allUsersTasksPublisher: Published<[String: [TaskModel]]>.Publisher { get }
    
    var queriedTasks: [TaskModel] { get set }
    var queriedTasksPublihser: Published<[TaskModel]>.Publisher { get }
    
    var currError: NetworkingManager.NetworkingError? { get set }
    
    var errorCount: Int { get set }
    var errorCountPublisher: Published<Int>.Publisher { get }
    
    func getWorkspaceTasks(userId: String, workspaceId: String)
    func createTask(dto: CreateTaskDTO, userId: String, workspaceId: String)
    func updateTaskStatus(taskId: String, status: TaskStatus, userId: String, workspaceId: String)
    func queryTasks(dto: QueryTasksDTO)
    func saveTask(dto: SaveTaskDTO, userId: String, workspaceId: String, isRejected: Bool, isVisible: Bool)
    func deleteTask(dto: DeleteTaskDTO, userId: String, workspaceId: String)
    func updateTask(dto: UpdateTaskDTO, userId: String, workspaceId: String)
}
