//
//  DocumentationViewModel.swift
//  NeedleApp
//
//  Created by matheusvb on 24/08/23.
//

import Foundation
import SwiftUI
import RichTextKit

@MainActor
class DocumentationViewModel<
    D: DocumentationDataServiceProtocol & ObservableObject
>: ObservableObject {
    @AppStorage("userID") var userID: String = "Default User"
    
    let context = RichTextContext()

    var documentationData: String
    
    @Published var documentationNS: NSAttributedString
    
    let documentId: String
    let workspaceId: String
    
    private var docDS: D
    
    init(workspaceId: String, documentId: String, documentationData: String, docDS: D) {
        self.documentationData = documentationData
        
        let decodedData = Data(base64Encoded: documentationData, options: .ignoreUnknownCharacters)
        do{
            let decoded = try NSAttributedString(data: decodedData!, format: .rtf)
            self.documentationNS = decoded
        }catch{
            self.documentationNS = NSAttributedString(string: "")
            print(error)
        }
        
        self.docDS = docDS
        self.documentId = documentId
        self.workspaceId = workspaceId
    }
    
    func updateDoc() {
        do {
            let data = try documentationNS.richTextData(for: .rtf)
            let encodedData = data.base64EncodedString(options: .lineLength64Characters)
            
            let dto = UpdateDocumentationDTO(id: documentId, text: encodedData, textString: documentationNS.string)
            
            self.docDS.updateDocumentation(data: dto, userId: userID, workspaceId: workspaceId)
        } catch {
            print("THROW")
        }
    }
}
