//
//  TaskDataServiceProtocol.swift
//  NeedleApp
//
//  Created by matheusvb on 18/08/23.
//

import Foundation

protocol TaskDataServiceProtocol: ObservableObject {
    func getWorkspaceTasks(userId: String, workspaceId: String)
    func createTask(dto: CreateTaskDTO, userId: String, workspaceId: String)
    func updateTaskStatus(taskId: String, status: TaskStatus, userId: String, workspaceId: String)
    func queryTasks(dto: QueryTasksDTO)
    func saveTask(dto: SaveTaskDTO, userId: String, workspaceId: String)
    func deleteTask(dto: DeleteTaskDTO, userId: String, workspaceId: String)
}
