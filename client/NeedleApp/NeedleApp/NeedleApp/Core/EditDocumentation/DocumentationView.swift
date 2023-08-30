//
//  DocumentationView.swift
//  NeedleApp
//
//  Created by matheusvb on 24/08/23.
//

import SwiftUI
import RichTextKit

struct DocumentationView: View {
    @ObservedObject var documentationViewModel: DocumentationViewModel<DocumentationDataService>
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var documentationNS: NSAttributedString
    
    init(workspaceId: String, documentId: String, documentationNS: Binding<NSAttributedString>) {
        self.documentationViewModel = DocumentationViewModel(workspaceId: workspaceId, documentId: documentId, docDS: DocumentationDataService.shared)
        self._documentationNS = documentationNS
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                editor
                leftBorder
                toolbar
            }
        }
        .frame(minHeight: 600)
        .background(Color.theme.grayBackground)
        .border(Color.theme.blackMain, width: 2)
    }
    
    var editor: some View {
        RichTextEditor(text: $documentationNS, context: documentationViewModel.context) {
                $0.textContentInset = CGSize(width: 10, height: 20)
            }
        .focusedValue(\.richTextContext, documentationViewModel.context)
        }
        
        var toolbar: some View {
            VStack {
                RichTextFormatSidebar(context: documentationViewModel.context)
                    .layoutPriority(-1)
                    .foregroundColor(Color.theme.blackMain)
            }
        }
        
        var leftBorder: some View {
            HStack {
               Rectangle()
                   .frame(width: 2)
                   .foregroundColor(Color.theme.blackMain)
           }
        }
}
