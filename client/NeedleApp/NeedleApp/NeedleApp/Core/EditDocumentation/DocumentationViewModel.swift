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
    @Published var documentationID: String
    @Published var documentationText: String
    @Published var documentationString: NSAttributedString
    @Published var isDeleting: Bool = false
    
    let context = RichTextContext()

    var dto: UpdateDocumentationDTO
    
    init(data: TaskModel, userID: String, workspaceID: String, documentationID: String, documentationText: String, documentationString: NSAttributedString, members: [User], isDeleting: Bool, docDS: D) {
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
            text: data.document?.text ?? "",
            textString: data.document?.textString ?? ""
        )
        
        self.setupBindings()
    }
    
    func setupBindings() {
        Publishers.CombineLatest3($documentationID, $documentationText, $documentationString)
            .sink(receiveValue: { [weak self] (documentationID, documentationText, documentationString) in
                self?.dto.id = documentationID
                self?.dto.text = documentationText
                self?.dto.textString = documentationString.string
            })
            .store(in: &cancellables)
    }

}
