//
//  WorkspaceDataService.swift
//  NeedleApp
//
//  Created by matheusvb on 03/08/23.
//

import Foundation
import Combine

class WorkspaceDataService: ObservableObject {
    static let shared = WorkspaceDataService()
    private init() {}
    
    @Published var currError: NetworkingManager.NetworkingError?
    @Published var errorCount: Int = 0
    
    @Published var workspaces: [Workspace] = []
    
    var workspaceSubscription: AnyCancellable?
    var createWorkspaceSubscription: AnyCancellable?
    var joinWorkspaceSubscription: AnyCancellable?
    
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
    
    func joinWorkspace(userId: String, accessCode: String) {
        guard let url = URL(string: Bundle.baseURL + "join") else { return }
        
        let dto = JoinWorkspaceDTO(userId: userId, accessCode: accessCode)
        
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
}
