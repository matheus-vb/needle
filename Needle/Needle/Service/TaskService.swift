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
    
    func createTask(taskInput: Task, completion: @escaping (_ result: Task?) -> Void) {
        let urlString = baseUrl + "task/create"
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["id": id, "text": text]
        
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
                let document = try decoder.decode(SingleDocumentResponse.self, from: data)
                
                completion(document.data)
                return
    
            } catch {
                print(error)
                completion(nil)
                return
            }
        }
    }
}
