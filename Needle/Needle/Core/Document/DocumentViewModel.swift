//
//  DocumentViewModel.swift
//  Needle
//
//  Created by matheusvb on 30/05/23.
//

import Foundation
import RichTextKit

extension DocumentView {
    @MainActor class DocumentViewModel: ObservableObject {
        @Published var taskId: String
        @Published var text = NSAttributedString.empty
        @Published var context = RichTextContext()
        
        init(taskId: String) {
            self.taskId = taskId
        }
        
        func getDocumentation() -> NSAttributedString {
            
            
            return NSAttributedString.empty
        }
    }
}
