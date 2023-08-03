//
//  NetworkingManager.swift
//  NeedleApp
//
//  Created by matheusvb on 31/07/23.
//

import Foundation
import Combine

class NetworkingManager{
    enum NetworkingError: LocalizedError, Equatable {
        case badURLResponse(url: URL)
        case unknown
        case tokenNotFound
        case expiredToken
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse: return "Bad response."
            case .unknown: return "Unknown error occured."
            case .tokenNotFound: return "User not authenticated."
            case .expiredToken: return "Expired token."
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
//        guard let token = KeychainSwift().get("token") else {
//            return Fail(error: NetworkingError.tokenNotFound)
//                .eraseToAnyPublisher()
//        }
        
        var request = URLRequest(url: url)
        //request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0, url: url)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func post(url: URL, body: Data) -> AnyPublisher<Data, Error> {
//        guard let token = KeychainSwift().get("token") else {
//            return Fail(error: NetworkingError.tokenNotFound)
//                .eraseToAnyPublisher()
//        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0, url: url)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {

        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            
            if let response = output.response as? HTTPURLResponse, response.statusCode == 403 {
                throw NetworkingError.expiredToken
            }
            
            throw NetworkingError.badURLResponse(url: url)
        }
        
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>, onError: (Error) -> Void){
        switch completion {
        case .finished:
            break
        case .failure(let error):
            if let networkingError = error as? NetworkingError {
                print(networkingError.localizedDescription)
                onError(networkingError)
            } else {
                print(error)
                onError(NetworkingError.unknown)
            }
        }
    }
}
