//
//  EditDocumentationView.swift
//  NeedleApp
//
//  Created by aaav on 27/07/23.
//

import SwiftUI

struct EditDocumentationView: View {
    
    let taskName : String
    let taskID : String
    
    @State var documentation : NSAttributedString = NSAttributedString.empty
    
    @State var data = Data()
    
    var options : [String] = ["Descrição", "Exemplo"]
    @State var selectedOption = "Descrição"
    
    //    let documentService = DocumentService(baseUrl: _URL)
    
    var body: some View {
        
        VStack(alignment: .leading){
            Text(taskName)
                .font(.largeTitle)
            HStack {
                Picker("", selection: $selectedOption) {
                    ForEach(options, id: \.self){
                        Text($0)
                    }
                }.pickerStyle(.segmented)
                    .labelsHidden()
                Spacer().layoutPriority(1)
            }
            
            textEditorView(documentation: $documentation)
            
            Button("Enviar"){
                print(documentation.string)
                do {
                    //UPLOAD
                    
                    data = try documentation.richTextData(for: .rtf)
                    let encodedData = data.base64EncodedString(options: .lineLength64Characters)
//                    documentService.updateDocumentation(id: docId, text: encodedData, plainText: documentation.string) { _ in }
                } catch {
                    print(error)
                }
            }
        }
        .padding()
        .onAppear {
            //LOAD RTF
            
//            documentService.getSingleDocumentation(taskId: taskId) { result in
//                if let result = result {
//                    print(result)
//                    docId = result.id
//
//                    let decodedData = Data(base64Encoded: result.text, options: .ignoreUnknownCharacters)
//
//                    do {
//                        let decoded = try NSAttributedString(data: decodedData!, format: .rtf)
//                        documentation = decoded
//                    } catch {
//                        print(error)
//                    }
//                }
//            }
            
        }
    }
}

struct EditDocumentationView_Previews: PreviewProvider {
    static var previews: some View {
        EditDocumentationView(taskName: "Task Exemplo", taskID: "8900")
    }
}
