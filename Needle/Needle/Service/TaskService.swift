//
//  TaskService.swift
//  Needle
//
//  Created by matheusvb on 30/05/23.
//

import Foundation

class TaskService {
    let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func updateStatus(taskId: String, status: String, completion: @escaping (_ result: Task?) -> Void) {
        let urlString = baseUrl + "task"
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["taskId": taskId, "stats": status]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data returned from server")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let task = try decoder.decode(SingleTaskResponse.self, from: data)
                
                completion(task.data)
                return
    
            } catch {
                print(error)
                completion(nil)
                return
            }
        }
    }
    
    func assignTask(id: String, userId: String, completion: @escaping ( _ result: Task?) -> Void) {
        let urlString = baseUrl + "task/assign"
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["id": id, "userId": userId]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data returned from server")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let task = try decoder.decode(SingleTaskResponse.self, from: data)
                
                completion(task.data)
                return
    
            } catch {
                print(error)
                completion(nil)
                return
            }
        }
    }
    
    func workspaceTasks(workspaceId: String, completion: @escaping (_ result: [Task]?) -> Void) {
        let urlString = baseUrl + "task/\(workspaceId)"
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data returned from server")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let task = try decoder.decode(TaskResponse.self, from: data)
                
                completion(task.data)
                return
    
            } catch {
                print(error)
                completion(nil)
                return
            }
        }
    }
    
    func createTask(accessCode: String, taskInput: Task, completion: @escaping (_ result: Task?) -> Void) {
        let urlString = baseUrl + "task/create"
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["userId": taskInput.userId, "accessCode": accessCode, "title": taskInput.title, "description": taskInput.description, "stats": taskInput.status, "type": taskInput.type, "endDate": taskInput.endDate]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data returned from server")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let task = try decoder.decode(SingleTaskResponse.self, from: data)
                
                completion(task.data)
                return
    
            } catch {
                print(error)
                completion(nil)
                return
            }
        }
    }
}
