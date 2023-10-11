//
//  UserDataService.swift
//  NeedleApp
//
//  Created by vivi on 05/10/23.
//

import Foundation
import Combine

class UserDataService: UserDataServiceProtocol {
    static let shared = UserDataService()
    private init() {}
    
    @Published var currError: NetworkingManager.NetworkingError?
    
    @Published var errorCount: Int = 0
    var errorCountPublisher: Published<Int>.Publisher { $errorCount }
    
    var deleteUserSubscription: AnyCancellable?
    
    func deleteUser(userId: String) {
        guard let url = URL(string: Bundle.baseURL + "user/delete/\(userId)") else { return }
        
        deleteUserSubscription = NetworkingManager.delete(url: url)
            .decode(type: TaskResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: {
                completion in NetworkingManager.handleCompletion(completion: completion) { error in
                    self.currError = error as? NetworkingManager.NetworkingError
                    self.errorCount += 1
                }
            }, receiveValue: { [weak self] _ in
                self?.deleteUserSubscription?.cancel()
            })
    }
}
