//
//  TaskDataService.swift
//  NeedleApp
//
//  Created by matheusvb on 04/08/23.
//

import Foundation
import Combine

class TaskDataService: TaskDataServiceProtocol {
    static let shared = TaskDataService()
    private init() {}
    
    @Published var currError: NetworkingManager.NetworkingError?
    
    @Published var errorCount: Int = 0
    var errorCountPublisher: Published<Int>.Publisher { $errorCount }
    
    @Published var allUsersTasks: [String: [TaskModel]] = [:]
    var allUsersTasksPublisher: Published<[String : [TaskModel]]>.Publisher { $allUsersTasks }

    @Published var queriedTasks: [TaskModel] = []
    var queriedTasksPublihser: Published<[TaskModel]>.Publisher { $queriedTasks }
    
    var getWorkspaceTasksSubscription: AnyCancellable?
    var getAllUsersTasksSubscription: AnyCancellable?
    var createTaskSubscription: AnyCancellable?
    var updateTaskStatusSubscription: AnyCancellable?
    var queryTasksSubscription: AnyCancellable?
    var saveTaskSubscription: AnyCancellable?
    var updateTaskIsVisibleSubscription : AnyCancellable?
    
    func getWorkspaceTasks(userId: String, workspaceId: String) {
        guard let url = URL(string: Bundle.baseURL + "task/\(workspaceId)") else { return }
        
        getWorkspaceTasksSubscription = NetworkingManager.download(url: url)
            .decode(type: TaskResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: {
                completion in NetworkingManager.handleCompletion(completion: completion) { error in
                    self.currError = error as? NetworkingManager.NetworkingError
                    self.errorCount += 1
                }
            }, receiveValue: { [weak self] (returnedTasks) in
                self?.allUsersTasks[workspaceId] = returnedTasks.data
                self?.getWorkspaceTasksSubscription?.cancel()
            })
    }
    
    func createTask(dto: CreateTaskDTO, userId: String, workspaceId: String) {
        guard let url = URL(string: Bundle.baseURL + "task/create") else { return }
        
        let parameters = convertToDictionary(dto)
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else { return }
        
        createTaskSubscription = NetworkingManager.post(url: url, body: jsonData)
            .sink(receiveCompletion: {
                completion in NetworkingManager.handleCompletion(completion: completion) { error in
                    self.currError = error as? NetworkingManager.NetworkingError
                    self.errorCount += 1
                }
            }, receiveValue: { [weak self] _ in
                self?.getWorkspaceTasks(userId: userId, workspaceId: workspaceId)
                self?.createTaskSubscription?.cancel()
            })
    }
    
    func updateTaskStatus(taskId: String, status: TaskStatus, userId: String, workspaceId: String) {
        guard let url = URL(string: Bundle.baseURL + "task") else { return }
        
        let dto = UpdateTaskStatusDTO(taskId: taskId, status: status.rawValue)
        
        let parameters = convertToDictionary(dto)
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else { return }
        
        updateTaskStatusSubscription = NetworkingManager.patch(url: url, body: jsonData)
            .sink(receiveCompletion: {
                completion in NetworkingManager.handleCompletion(completion: completion) { error in
                    self.currError = error as? NetworkingManager.NetworkingError
                    self.errorCount += 1
                }
            }, receiveValue: { [weak self] _ in
                self?.getWorkspaceTasks(userId: userId, workspaceId: workspaceId)
                self?.createTaskSubscription?.cancel()
            })
    }
    
    func queryTasks(dto: QueryTasksDTO) {
        guard let url = URL(string: Bundle.baseURL + "task/query/\(dto.workspaceId)?\(dto.toQueryString())") else { return }
        
        queryTasksSubscription = NetworkingManager.download(url: url)
            .decode(type: TaskResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: {
                completion in NetworkingManager.handleCompletion(completion: completion) { error in
                    self.currError = error as? NetworkingManager.NetworkingError
                    self.errorCount += 1
                }
            }, receiveValue: { [weak self] (returnedTasks) in
                self?.queriedTasks = returnedTasks.data
                self?.queryTasksSubscription?.cancel()
            })
    }
    
    func updateTask(dto: UpdateTaskDTO, userId: String, workspaceId: String) {
        guard let url = URL(string: Bundle.baseURL + "edit/task") else { return }

        let parameters = convertToDictionary(dto)
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else { return }

       saveTaskSubscription = NetworkingManager.patch(url: url, body: jsonData)
            .sink(receiveCompletion: {
                completion in NetworkingManager.handleCompletion(completion: completion) { error in
                    self.currError = error as? NetworkingManager.NetworkingError
                    self.errorCount += 1
                }
            }, receiveValue: { [weak self] _ in
                self?.getWorkspaceTasks(userId: userId, workspaceId: workspaceId)
                self?.createTaskSubscription?.cancel()
            })
    }
    
    func saveTask(dto: SaveTaskDTO, userId: String, workspaceId: String, isRejected: Bool, isVisible: Bool) {
        guard let url = URL(string: Bundle.baseURL + "update/task") else { return }

        let parameters = convertToDictionary(dto)
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else { return }

       saveTaskSubscription = NetworkingManager.patch(url: url, body: jsonData)
            .sink(receiveCompletion: {
                completion in NetworkingManager.handleCompletion(completion: completion) { error in
                    self.currError = error as? NetworkingManager.NetworkingError
                    self.errorCount += 1
                }
            }, receiveValue: { [weak self] _ in
                self?.getWorkspaceTasks(userId: userId, workspaceId: workspaceId)
                self?.createTaskSubscription?.cancel()
            })
    }
    
    func deleteTask(dto: DeleteTaskDTO, userId: String, workspaceId: String) {
        guard let url = URL(string: Bundle.baseURL + "task/delete/\(dto.taskId)") else { return }
       saveTaskSubscription = NetworkingManager.delete(url: url)
            .sink(receiveCompletion: {
                completion in NetworkingManager.handleCompletion(completion: completion) { error in
                    self.currError = error as? NetworkingManager.NetworkingError
                    self.errorCount += 1
                }
            }, receiveValue: { [weak self] _ in
                self?.getWorkspaceTasks(userId: userId, workspaceId: workspaceId)
                self?.createTaskSubscription?.cancel()
            })
    }
    
    func updateTaskVisibility(taskId: String, isVisible: Bool, userId: String, workspaceId: String) {
        guard let url = URL(string: Bundle.baseURL + "task/update/isVisible") else { return }
        
        let dto = UpdateIsVisibleDTO(taskId: taskId, isVisible: !isVisible)
        
        let parameters = convertToDictionary(dto)
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else { return }
        
        updateTaskIsVisibleSubscription = NetworkingManager.patch(url: url, body: jsonData)
            .sink(receiveCompletion: {
                completion in NetworkingManager.handleCompletion(completion: completion) { error in
                    self.currError = error as? NetworkingManager.NetworkingError
                    self.errorCount += 1
                }
            }, receiveValue: { [weak self] _ in
                self?.getWorkspaceTasks(userId: userId, workspaceId: workspaceId)
                self?.updateTaskIsVisibleSubscription?.cancel()
            })
    }
}
