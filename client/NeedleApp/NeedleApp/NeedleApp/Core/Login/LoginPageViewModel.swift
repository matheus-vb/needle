//
//  LoginPageViewModel.swift
//  NeedleApp
//
//  Created by matheusvb on 03/08/23.
//

import Foundation
import Combine
import AuthenticationServices

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
    
    func handleResult(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let auth):
            switch auth.credential {
            case let authCredential as ASAuthorizationAppleIDCredential:
                //print(authCredential)
                let userID = authCredential.user
                let email = authCredential.email
                let firstName = authCredential.fullName?.givenName
                let lastName = authCredential.fullName?.familyName
                
                AuthenticationManager.shared.singIn(userId: userID, email: email, name: firstName)

                NotificationDataService.shared.updateDeviceToken(userId: userID)
                
                WorkspaceDataService.shared.getUsersWorkspaces(userId: userID)
                
                NotificationDataService.shared.getUserNotifications(userId: userID)
                
            default:
                break
            }
            
        case .failure(let error):
            print(error)
        }
    }
}
