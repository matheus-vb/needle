//
//  DocumentsViewModel.swift
//  Needle
//
//  Created by jpcm2 on 31/05/23.
//

import Foundation

class DocumentsViewModel: ObservableObject{
    @Published var documents: [Document]?
    @Published var searchString = ""
    
    let documentService = DocumentService(baseUrl: _URL)
    let workspaceId: String
    
    init(workspaceId: String) {
        self.workspaceId = workspaceId
        
        print("IN1")
        
        DispatchQueue.main.async {
            self.documentService.getWorkspaceDocumentations(workspaceId: workspaceId) { result in
                if let result {
                    self.documents = result
                }
            }
        }
    }
    
    func queryDocuments(accessCode: String) {
        DispatchQueue.main.async {
            self.documentService.queryDocumentation(accessCode: accessCode, query: self.searchString) { result in
                if let result {
                    self.documents = result
                }
            }
        }
    }
}
