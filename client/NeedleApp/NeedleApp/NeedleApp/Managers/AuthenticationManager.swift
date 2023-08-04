//
//  AuthenticationManager.swift
//  NeedleApp
//
//  Created by matheusvb on 03/08/23.
//

import Foundation
import Combine

class AuthenticationManager: ObservableObject {
    static let shared = AuthenticationManager()
    
    private init() {}
    
    @Published var user: User?
    
    var signInSubscription: AnyCancellable?
    
    @Published var currError: NetworkingManager.NetworkingError?
    @Published var errorCount: Int = 0
    
    func singIn(userId: String, email: String? = nil, name: String? = nil) {
        guard let url = URL(string: Bundle.baseURL + "signin") else { return }
        
        let dto = SignInDTO(userId: userId, email: email, name: name)
        
        let parameters = convertToDictionary(dto)
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else { return }
        print(url)
        print(parameters)
        signInSubscription = NetworkingManager.post(url: url, body: jsonData)
            .decode(type: UserResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: {
                completion in NetworkingManager.handleCompletion(completion: completion) { error in
                    print("ERROR -> ", error)
                    self.currError = error as? NetworkingManager.NetworkingError
                    self.errorCount += 1
                }
            }, receiveValue: { [weak self] (returnedUser) in
                print("LOGGED")
                self?.user = returnedUser.data
                print(self?.user)
                self?.signInSubscription?.cancel()
            })
    }
}
