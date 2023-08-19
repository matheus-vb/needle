//
//  AuthenticationServiceProtocol.swift
//  NeedleApp
//
//  Created by matheusvb on 18/08/23.
//

import Foundation

protocol AuthenticationManagerProtocol: ObservableObject {
    var user: User? { get set }
    var roles : [String: String] { get set }
    var currError: NetworkingManager.NetworkingError? { get set }
    
    func singIn(userId: String, email: String?, name: String?)
    func getRoleInWorkspace(userId: String, workspaceId: String)
}
