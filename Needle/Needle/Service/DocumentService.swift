//
//  DocumentService.swift
//  Needle
//
//  Created by matheusvb on 30/05/23.
//

import Foundation

class DocumentService {
    let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func updateDocumentation(id: String, text: String, completion: @escaping (_ result: Document?) -> Void) {
        let urlString = baseUrl + "document"
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
        task.resume()
    }
    
    func getSingleDocumentation(taskId: String, completion: @escaping (_ result: Document?) -> Void) {
        let urlString = baseUrl + "document/\(taskId)"
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
                let document = try decoder.decode(SingleDocumentResponse.self, from: data)
                
                completion(document.data)
                return
    
            } catch {
                print(error)
                completion(nil)
                return
            }
        }
        task.resume()
    }
    
    func getWorkspaceDocumentations(workspaceId: String, completion: @escaping (_ result: [Document]?) -> Void) {
        let urlString = baseUrl + "workspace/\(workspaceId)"
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
                let document = try decoder.decode(DocumentResponse.self, from: data)
                print("OK")
                completion(document.data)
                return
    
            } catch {
                print(error)
                completion(nil)
                return
            }
        }
        task.resume()
    }
    
    func queryDocumentation(accessCode: String, query: String, completion: @escaping (_ result: [Document]?) -> Void) {
        let urlString = baseUrl + "document/title/\(accessCode)/\(query)"
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
                let document = try decoder.decode(DocumentResponse.self, from: data)
                print("OK")
                completion(document.data)
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
