//
//  WorkspaceDataService.swift
//  NeedleApp
//
//  Created by matheusvb on 03/08/23.
//

import Foundation
import Combine

class WorkspaceDataService: WorkspaceDataServiceProtocol {
    static let shared = WorkspaceDataService()
    private init() {}
    
    @Published var currError: NetworkingManager.NetworkingError?
    
    @Published var errorCount: Int = 0
    var errorCountPublisher: Published<Int>.Publisher { $errorCount }
    
    @Published var workspaces: [Workspace] = []
    var workspacePublisher: Published<[Workspace]>.Publisher { $workspaces }
    
    @Published var members: [String: [User]] = [:]
    var membersPublisher: Published<[String : [User]]>.Publisher { $members }
    
    var workspaceSubscription: AnyCancellable?
    var createWorkspaceSubscription: AnyCancellable?
    var joinWorkspaceSubscription: AnyCancellable?
    var deleteWorkspaceSubscription: AnyCancellable?
    var getMembersSubscription: AnyCancellable?
    var deleteWorkspaceMemberSubscription : AnyCancellable?
    
    func getUsersWorkspaces(userId: String) {
        guard let url = URL(string: Bundle.baseURL + "workspace/list/\(userId)") else { return }
        
        workspaceSubscription = NetworkingManager.download(url: url)
            .decode(type: WorkspacesResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: {
                completion in NetworkingManager.handleCompletion(completion: completion) { error in
                    self.currError = error as? NetworkingManager.NetworkingError
                    self.errorCount += 1
                }
            }, receiveValue: { [weak self] (returnedWorkspaces) in
                self?.workspaces = returnedWorkspaces.data
                self?.workspaces.sort{ $0.name < $1.name }
                self?.workspaceSubscription?.cancel()
            })
    }
    
    func createWorkspace(userId: String, name: String) {
        guard let url = URL(string: Bundle.baseURL + "workspace") else { return }
        
        let dto = CreateWorkspaceDTO(name: name, userId: userId)
        
        let parameters = convertToDictionary(dto)
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else { return }
        
        createWorkspaceSubscription = NetworkingManager.post(url: url, body: jsonData)
            .sink(receiveCompletion: {
                completion in NetworkingManager.handleCompletion(completion: completion) { error in
                    self.currError = error as? NetworkingManager.NetworkingError
                    self.errorCount += 1
                }
            }, receiveValue: { [weak self] _ in
                self?.getUsersWorkspaces(userId: userId)
                self?.createWorkspaceSubscription?.cancel()
            })
        
    }
    
    func joinWorkspace(userId: String, accessCode: String, role: Role) {
        guard let url = URL(string: Bundle.baseURL + "join") else { return }
        
        let dto = JoinWorkspaceDTO(userId: userId, accessCode: accessCode, role: role.rawValue)
        
        let parameters = convertToDictionary(dto)
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else { return }
        
        joinWorkspaceSubscription = NetworkingManager.post(url: url, body: jsonData)
            .sink(receiveCompletion: {
                completion in NetworkingManager.handleCompletion(completion: completion) { error in
                    self.currError = error as? NetworkingManager.NetworkingError
                    self.errorCount += 1
                }
            }, receiveValue: { [weak self] _ in
                self?.getUsersWorkspaces(userId: userId)
                self?.workspaceSubscription?.cancel()
            })
    }
    
    func deleteWorkspace(accessCode: String, userId: String) {
        guard let url = URL(string: Bundle.baseURL + "workspace/delete/\(accessCode)") else { return }
        
        deleteWorkspaceSubscription = NetworkingManager.delete(url: url)
            .sink(receiveCompletion: {
                completion in NetworkingManager.handleCompletion(completion: completion) { error in
                    self.currError = error as? NetworkingManager.NetworkingError
                    self.errorCount += 1
                }
            }, receiveValue: { [weak self] _ in
                self?.getUsersWorkspaces(userId: userId)
                self?.workspaceSubscription?.cancel()
            })
    }
        
    func deleteWorkspaceMember(userId: String, workspaceId : String) {
        guard let url = URL(string: Bundle.baseURL + "members/delete/\(userId)/\(workspaceId)") else { return }
        
        deleteWorkspaceMemberSubscription = NetworkingManager.delete(url: url)
            .sink(receiveCompletion: {
                completion in NetworkingManager.handleCompletion(completion: completion) { error in
                    self.currError = error as? NetworkingManager.NetworkingError
                    self.errorCount += 1
                }
            }, receiveValue: { [weak self] _ in
                self?.getWorkspaceMembers(workspaceId: workspaceId)
                self?.deleteWorkspaceMemberSubscription?.cancel()
            })
    }
    
    func getWorkspaceMembers(workspaceId: String) {
        guard let url = URL(string: Bundle.baseURL + "members/\(workspaceId)") else { return }
        
        getMembersSubscription = NetworkingManager.download(url: url)
            .decode(type: UsersResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: {
                completion in NetworkingManager.handleCompletion(completion: completion) { error in
                    self.currError = error as? NetworkingManager.NetworkingError
                    self.errorCount += 1
                }
            }, receiveValue: { [weak self] (returnedUsers) in
                self?.members[workspaceId] = returnedUsers.data
                self?.getMembersSubscription?.cancel()
            })
    }
}
