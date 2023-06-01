//
//  AuthService.swift
//  Needle
//
//  Created by matheusvb on 31/05/23.
//

import Foundation

class AuthService {
    let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func register(user: User, password: String, completion: @escaping (_ result: User?) -> Void) {
        let urlString = baseUrl + "register"
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["name": user.name, "email": user.email, "password": password, "role": user.role]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("ERROR ---> \(error) ----|||")
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
                let task = try decoder.decode(SingleUserResponse.self, from: data)
                
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
    
    func login(email: String, password: String, completion: @escaping (_ result: User?) -> Void) {
        let urlString = baseUrl + "auth"
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["email": email, "password": password]
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
                let task = try decoder.decode(SingleUserResponse.self, from: data)
                
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
