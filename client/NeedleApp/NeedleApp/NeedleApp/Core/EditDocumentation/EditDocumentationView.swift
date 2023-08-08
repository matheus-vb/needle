//
//  EditDocumentationView.swift
//  NeedleApp
//
//  Created by aaav on 27/07/23.
//

import SwiftUI
import RichTextKit

struct EditDocumentationView: View {
    
    @Binding var documentation : NSAttributedString
    @EnvironmentObject var editTaskViewModel: EditTaskViewModel
    
    //let taskName : String
    //let taskID : String
    
    @StateObject var context = RichTextContext()
    
    @State var data = Data()
    @State var saved : String = ""
    
    @State var selectedOption = "Descrição"
    
    //    let documentService = DocumentService(baseUrl: _URL)
    
    var body: some View {
        
        VStack(alignment: .leading){
            HStack{
                editor
                toolbar
            }
            
            Button("Receber"){
                let decodedData = Data(base64Encoded: saved, options: .ignoreUnknownCharacters)
                do{
                    let decoded = try NSAttributedString(data: decodedData!, format: .rtf)
                    documentation = decoded
                    context.setAttributedString(to: documentation)
                } catch {
                    print(error)
                }
            }
            
            Button("Enviar"){
                do {
                    data = try documentation.richTextData(for: .rtf)
                    let encodedData = data.base64EncodedString(options: .lineLength64Characters)
                    saved = encodedData
                    
                    //                    documentService.updateDocumentation(id: docId, text: encodedData, plainText: documentation.string) { _ in }
                    
                } catch {
                    print(error)
                }
            }
        }
        .padding()
        .onAppear {
//            documentService.getSingleDocumentation(taskId: taskId) { result in
//                if let result = result {
//                    docId = result.id
//
//                    let decodedData = Data(base64Encoded: result.text, options: .ignoreUnknownCharacters)
//
//                    do {
//                        let decoded = try NSAttributedString(data: decodedData!, format: .rtf)
//                        documentation = decoded
//                        context.setAttributedString(to: documentation)
//                    } catch {
//                        print(error)
//                    }
//                }
//            }
            
        }
    }
}

private extension EditDocumentationView {
    
    var editor: some View {
        RichTextEditor(text: $documentation, context: context) {
            $0.textContentInset = CGSize(width: 10, height: 20)
        }
        .frame(minWidth: 400)
        .focusedValue(\.richTextContext, context)
    }
    
    var toolbar: some View {
        
        RichTextFormatSidebar(context: context)
            .frame(minWidth: 200)
            .layoutPriority(-1)
    }
}
