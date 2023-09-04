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
        
    let documentId: String
    let workspaceId: String
    
    private var docDS: D
    
    init(workspaceId: String, documentId: String, docDS: D) {
        self.docDS = docDS
        self.documentId = documentId
        self.workspaceId = workspaceId
    }
    
    func getPriorityFlagColor(priority: TaskPriority) -> Color {
        switch priority {
        case .HIGH:
            return Color.theme.redMain
        case .VERY_HIGH:
            return .purple
        case .MEDIUM:
            return Color.theme.orangeKanban
        case .LOW:
            return Color.theme.greenKanban
        }
    }
}
