//
//  DocumentationViewModel.swift
//  NeedleApp
//
//  Created by Bof on 09/10/23.
//

import Foundation
import SwiftUI
import Combine
import RichTextKit

class DocumentationViewModel <
    D: DocumentationDataServiceProtocol & ObservableObject
>: ObservableObject{
    @AppStorage("userID") var userID: String = "Default User"
    private var cancellables = Set<AnyCancellable>()

    private var docDS: D
    
    let selectedTask: TaskModel
    var workspaceID: String
    var docReview: String = NSLocalizedString("Comente a documentação", comment: "")
    @Published var documentationID: String
    @Published var documentationText: String
    @Published var documentationString: NSAttributedString
    @Published var isDeleting: Bool = false
    
    let context = RichTextContext()

    @State var dto: UpdateDocumentationDTO
    
    init(data: TaskModel, userID: String, workspaceID: String, documentationID: String, documentationText: String, documentationString: NSAttributedString, members: [String : [User]], isDeleting: Bool, docDS: D) {
        self.selectedTask = data
        self.userID = userID
        self.workspaceID = workspaceID
        self.documentationID = documentationID
        self.documentationText = documentationText
        self.documentationString = NSAttributedString(string: data.document?.text ?? "")
        self.isDeleting = isDeleting
        self.docDS = docDS

        let decodedData = Data(base64Encoded: data.document?.text ?? "", options: .ignoreUnknownCharacters)
        do{
            let decoded = try NSAttributedString(data: decodedData!, format: .rtf)
            self.documentationString = decoded
        }catch{
            print(error)
        }
        
        self.dto = UpdateDocumentationDTO(
            id: documentationID,
            text: documentationText,
            textString: documentationString.string
        )
    }
    
    func saveDoc() {
        do{
            let NSDocumentation = self.documentationString
            let StrDocumentation = NSDocumentation.string
            let data = try NSDocumentation.richTextData(for: .rtf)
            let encodedData = data.base64EncodedString(options: .lineLength64Characters)
            let newDto = UpdateDocumentationDTO(id: documentationID, text: encodedData, textString: StrDocumentation)
            print("dto: \(newDto), userId: \(userID), workspaceId: \(workspaceID)")
            docDS.updateDocumentation(data: newDto, userId: userID, workspaceId: workspaceID)
        }catch{
            print("ERRO NO DECODE")
        }
    }

}
