//
//  WorkspaceDataServiceMock.swift
//  NeedleAppTests
//
//  Created by jpcm2 on 04/09/23.
//
import Foundation
class WorkspaceDataServiceMock: WorkspaceDataServiceProtocol{
    let db: DBMock
    @Published var workspaces: [Workspace] = []
    var workspacePublisher: Published<[Workspace]>.Publisher {$workspaces}
    @Published var members: [String : [User]] = [:]
    var membersPublisher: Published<[String : [User]]>.Publisher {$members}
    var currError: NetworkingManager.NetworkingError?
    init(db: DBMock) {
        self.db = db
    }
    func getUsersWorkspaces(userId: String) {
        guard let userWorkspaces = db.workspaces[userId] else {return}
        self.workspaces = userWorkspaces
    }
    func createWorkspace(userId: String, name: String) {
        let workspaceID = "1"
        let workspaceAccessCode = "123"
        let userName = "Medeiros"
        let userEmail = "medeiros@email.com"
        guard let userRole = Role(rawValue: "PRODUCT_MANAGER") else {return}
        db.workspaces[userId]?.append(Workspace(id: workspaceID, accessCode: workspaceAccessCode, name: name, users: [PmMember(id: "1", userRole: "PRODUCT_MANAGER", userId: userId, workspaceId: workspaceID, user: UserInfo(name: userName))]))
        db.usersInWorkspace[workspaceID]?.append(User(id: userId, name: userName, email: userEmail, workspaces: [UserWorkspace(userRole: userRole)]))
    }
    func joinWorkspace(userId: String, accessCode: String, role: Role) {
        let workspaceID = "1"
        let workspaceName = "name"
        let workspacePM = PmMember(id: "2", userRole: "PRODUCT_MANAGER", userId: "2", workspaceId: workspaceID, user: UserInfo(name: "pm"))
        let newUser = PmMember(id: "3", userRole: role.rawValue, userId: userId, workspaceId: workspaceID, user: UserInfo(name:"membro"))
        db.workspaces[userId]?.append(Workspace(id: workspaceID, accessCode: accessCode, name: workspaceName, users: [workspacePM, newUser]))
        db.usersInWorkspace[workspaceID]?.append(User(id: userId, name: "membro", email: "membro@email.com", workspaces: [UserWorkspace(userRole: role)]))
    }
    func deleteWorkspace(accessCode: String, userId: String) {
        guard let workspaceId = db.workspaces[userId]?.firstIndex(where: {$0.accessCode == accessCode})else {return}
        db.workspaces[userId]!.remove(at: workspaceId)
        self.getUsersWorkspaces(userId: userId)
    }
    func getWorkspaceMembers(workspaceId: String) {
        guard let users = db.usersInWorkspace[workspaceId] else {return}
        self.members[workspaceId] = users
    }
}
