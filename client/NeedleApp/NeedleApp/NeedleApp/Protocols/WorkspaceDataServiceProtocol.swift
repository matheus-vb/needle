//
//  WorkspaceDataServiceProtocol.swift
//  NeedleApp
//
//  Created by matheusvb on 18/08/23.
//

import Foundation

protocol WorkspaceDataServiceProtocol: ObservableObject {
    var workspaces: [Workspace] { get set }
    var workspacePublisher: Published<[Workspace]>.Publisher { get }
    
    var members: [String: [User]] { get set }
    var membersPublisher: Published<[String: [User]]>.Publisher { get }
    
    var currError: NetworkingManager.NetworkingError? { get set }
    
    var errorCount: Int { get set }
    var errorCountPublisher: Published<Int>.Publisher { get }
    
    func getUsersWorkspaces(userId: String)
    func createWorkspace(userId: String, name: String)
    func joinWorkspace(userId: String, accessCode: String, role: Role)
    func deleteWorkspace(accessCode: String, userId: String)
    func getWorkspaceMembers(workspaceId: String)
    func deleteWorkspaceMember(userId: String, workspaceId : String)
    
}
