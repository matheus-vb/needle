//
//  AuthenticationServiceProtocol.swift
//  NeedleApp
//
//  Created by matheusvb on 18/08/23.
//

import Foundation

protocol AuthenticationManagerProtocol: ObservableObject {
    var user: User? { get set }
    
    var roles : [String: Role] { get set }
    var rolesPublihser: Published<[String: Role]>.Publisher { get }
    
    var currError: NetworkingManager.NetworkingError? { get set }
    
    var errorCount: Int { get set }
    var errorCountPublisher: Published<Int>.Publisher { get }
    
    func singIn(userId: String, email: String?, name: String?)
    func getRoleInWorkspace(userId: String, workspaceId: String)
}
