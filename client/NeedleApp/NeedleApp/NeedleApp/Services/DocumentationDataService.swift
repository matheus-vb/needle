//
//  DocumentationService.swift
//  NeedleApp
//
//  Created by jpcm2 on 08/08/23.
//

import Foundation
import Combine

class DocumentationDataService{
    static let shared = DocumentationDataService()
    private init() {}
    
    @Published var currError: NetworkingManager.NetworkingError?
    @Published var errorCount: Int = 0
    
    var updateDocumentationTaskSubscription: AnyCancellable?
    
    func updateDocumentation(data: UpdateDocumentationDTO, userId: String, workspaceId: String){
        guard let url = URL(string: Bundle.baseURL + "document") else { return }
        
        let parameters = convertToDictionary(data)
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else { return }
        print(jsonData)
        print(parameters)
        print(url)
        updateDocumentationTaskSubscription = NetworkingManager.patch(url: url, body: jsonData)
            .sink(receiveCompletion: {
                completion in NetworkingManager.handleCompletion(completion: completion) { error in
                    self.currError = error as? NetworkingManager.NetworkingError
                    self.errorCount += 1
                }
            }, receiveValue: { [weak self] _ in
                print("ooooooooou")
                TaskDataService.shared.getWorkspaceTasks(userId: userId, workspaceId: workspaceId)
                self?.updateDocumentationTaskSubscription?.cancel()
            })
    }
}