//
//  WorkspaceDataServiceProtocol.swift
//  NeedleApp
//
//  Created by matheusvb on 18/08/23.
//

import Foundation

protocol WorkspaceDataServiceProtocol: ObservableObject {
    func getUsersWorkspaces(userId: String)
    func createWorkspace(userId: String, name: String)
    func joinWorkspace(userId: String, accessCode: String, role: Role)
    func deleteWorkspace(accessCode: String, userId: String)
    func getWorkspaceMembers(workspaceId: String)
}
