//
//  DocumentView.swift
//  Needle
//
//  Created by matheusvb on 30/05/23.
//

import SwiftUI
import RichTextKit

struct DocumentView: View {
    @State var text = NSAttributedString.empty
    @StateObject var context = RichTextContext()
    @State var data = Data()
    
    @State var docId: String = ""
    
    let taskId: String
    let documentService = DocumentService(baseUrl: _URL)
    
    var editor: some View {
        RichTextEditor(text: $text, context: context) {
            $0.textContentInset = CGSize(width: 10, height: 20)
        }
        .focusedValue(\.richTextContext, context)
    }
    
    var toolbar: some View {
        RichTextFormatSidebar(context: context)
            .frame(maxWidth: 300)
    }
    
    var body: some View {
        HStack {
            VStack {
                editor
            }
            HStack {
                Spacer(minLength: 100)
                VStack {
                    toolbar
                    Button("Send") {
                        do {
                            data = try text.richTextData(for: .rtf)
                            let encodedData = data.base64EncodedString(options: .lineLength64Characters)
                            documentService.updateDocumentation(id: docId, text: encodedData) { _ in }
                        } catch {
                            print(error)
                        }
                    }
                    Spacer(minLength: 100)
                }
            }
        }
        .onAppear {
            documentService.getSingleDocumentation(taskId: taskId) { result in
                if let result = result {
                    print(result)
                    docId = result.id
                    
                    let decodedData = Data(base64Encoded: result.text, options: .ignoreUnknownCharacters)
                    
                    do {
                        let decoded = try NSAttributedString(data: decodedData!, format: .rtf)
                        text = decoded
                        print(decoded)
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}
