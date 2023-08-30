//
//  AuthenticationManagerMock.swift
//  NeedleAppTests
//
//  Created by matheusvb on 30/08/23.
//

import Foundation
import Combine

class AuthenticationManagerMock: AuthenticationManagerProtocol {
    var currError: NetworkingManager.NetworkingError?
    
    let db: DBMock
    
    init (db: DBMock) {
        self.db = db
    }
    
    @Published var user: User?
    @Published var roles: [String: Role] = [:]
    var rolesPublihser: Published<[String: Role]>.Publisher { $roles }
    
    func singIn(userId: String, email: String?, name: String?) {
        guard let user = db.users.first(where: { $0.id == userId }) else {
            guard let email, let name else { return } //TODO: add error
            
            let currUser = User(id: userId, name: name, email: email, workspaces: [])
            
            db.users.append(currUser)
            self.user = currUser
            
            return
        }
        
        self.user = user
    }
    
    func getRoleInWorkspace(userId: String, workspaceId: String) {
        guard let roleInWorkspace = db.roles[workspaceId] else { return } //TODO: add error
        
        self.roles[workspaceId] = roleInWorkspace
    }
}
