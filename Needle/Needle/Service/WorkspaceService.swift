//
//  WorkspaceService.swift
//  Needle
//
//  Created by matheusvb on 31/05/23.
//

import Foundation

class WorkspaceService {
    let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func returnCreatedWorkspace(name: String, userId: String) async -> Workspace? {
        var workspace: Workspace?
        let semaphore = DispatchSemaphore(value: 0)
        
        self.createWorkspace(name: name, userId: userId) { result in
            if let result = result {
                workspace = result
                semaphore.signal()
            } else {
                workspace = nil
                semaphore.signal()
            }
        }
        
        semaphore.wait()
        return workspace
    }
    
    func returnWorkspaces(id: String) async -> [Workspace] {
        var workspaces: [Workspace] = []
        let semaphore = DispatchSemaphore(value: 0)
        
        self.listUserWorkspaces(id: id) { result in
            if let result = result {
                workspaces = result
                semaphore.signal()
            } else {
                workspaces = []
                semaphore.signal()
            }
        }
        
        semaphore.wait()
        return workspaces
    }
    
    func createWorkspace(name: String, userId: String, completion: @escaping (_ result: Workspace?) -> Void) {
        let urlString = baseUrl + "workspace"
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["name": name, "userId": userId]
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
                let task = try decoder.decode(SingleWorkspaceResponse.self, from: data)
                
                completion(task.data)
                return
    
            } catch {
                print(error)
                completion(nil)
                return
            }
        }
        task.resume()
    }
    
    func joinWorkspace(userId: String, accessCode: String, completion: @escaping (_ result: Workspace?) -> Void) {
        let urlString = baseUrl + "join"
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["userId": userId, "accessCode": accessCode]
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
                let task = try decoder.decode(SingleWorkspaceResponse.self, from: data)
                
                completion(task.data)
                return
    
            } catch {
                print(error)
                completion(nil)
                return
            }
        }
        task.resume()
    }
    
    func listUserWorkspaces(id: String, completion: @escaping (_ result: [Workspace]?) -> Void) {
        let urlString = baseUrl + "workspace/list/\(id)"
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
                let task = try decoder.decode(WorkspaceResponse.self, from: data)
                
                completion(task.data)
                return
    
            } catch {
                print(error)
                completion(nil)
                return
            }
        }
        task.resume()
    }
}
