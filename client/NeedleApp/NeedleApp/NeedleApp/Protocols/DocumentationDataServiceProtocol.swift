//
//  DocumentationDataServiceProtocol.swift
//  NeedleApp
//
//  Created by matheusvb on 18/08/23.
//

import Foundation

protocol DocumentationDataServiceProtocol: ObservableObject {
    var currError: NetworkingManager.NetworkingError? { get set }
    
    func updateDocumentation(data: UpdateDocumentationDTO, userId: String, workspaceId: String)
}
