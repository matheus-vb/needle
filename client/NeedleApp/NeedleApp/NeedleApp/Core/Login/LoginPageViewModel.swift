//
//  LoginPageViewModel.swift
//  NeedleApp
//
//  Created by matheusvb on 03/08/23.
//

import Foundation
import Combine
import AuthenticationServices
import SwiftUI

class LoginPageViewModel<A: AuthenticationManagerProtocol & ObservableObject, N: NotificationDataServiceProtocol & ObservableObject, W: WorkspaceDataServiceProtocol & ObservableObject>: ObservableObject {
    
    @ObservedObject var authManager: A
    @ObservedObject var notificationDS: N
    @ObservedObject var workspaceDS: W

    @Published var user: User?
    
    private var cancellablels = Set<AnyCancellable>()
    
    
    init(manager: A, notificationDS: N, workpaceDS: W) {
        self.authManager = manager
        self.notificationDS = notificationDS
        self.workspaceDS = workpaceDS
        
        addSubscribers()
    }
    
    func addSubscribers() {
        authManager.objectWillChange
            .sink(receiveValue: {[weak self] returnedUser in
                self?.user = returnedUser as? User
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
                //let lastName = authCredential.fullName?.familyName
                
                authManager.singIn(userId: userID, email: email, name: firstName)

                notificationDS.updateDeviceToken(userId: userID)
                
                workspaceDS.getUsersWorkspaces(userId: userID)
                
                notificationDS.getUserNotifications(userId: userID)
                
            default:
                break
            }
            
        case .failure(let error):
            print(error)
        }
    }
}
