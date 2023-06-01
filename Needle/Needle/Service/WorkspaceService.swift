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
