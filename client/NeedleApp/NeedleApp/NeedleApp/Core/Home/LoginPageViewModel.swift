//
//  LoginPageViewModel.swift
//  NeedleApp
//
//  Created by matheusvb on 03/08/23.
//

import Foundation
import Combine

class LoginPageViewModel: ObservableObject {
    private var authManager = AuthenticationManager.shared
    private var cancellablels = Set<AnyCancellable>()
    
    @Published var user: User?
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        authManager.$user
            .sink(receiveValue: {[weak self] returnedUser in
                self?.user = returnedUser
            })
            .store(in: &cancellablels)
    }
}
