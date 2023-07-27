//
//  EditDocumentationView.swift
//  NeedleApp
//
//  Created by aaav on 27/07/23.
//

import SwiftUI
import RichTextKit


struct EditDocumentationView: View {
    
    @State
    private var documentation = NSAttributedString.empty
    
    @StateObject
    var context = RichTextContext()
    
    @State var data = Data()
    
    var options : [String] = ["Descrição", "Exemplo"]
    @State var selectedOption = "Descrição"
    
    var body: some View {
        
        VStack(alignment: .leading){
            Text("Task exemplo")
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
            
            HStack{
                RichTextEditor(text: $documentation, context: context)
                RichTextFormatSidebar(context: context)
                    .frame(minWidth: 200)
                    .layoutPriority(-1)
            }
            
            Button("Enviar"){
                print(documentation.string)
                do {
                    data = try documentation.richTextData(for: .rtf)
                    let encodedData = data.base64EncodedString(options: .lineLength64Characters)
//                    documentService.updateDocumentation(id: docId, text: encodedData) { _ in }
                } catch {
                    print(error)
                }
            }
        }
        .padding()
    }
}

struct EditDocumentationView_Previews: PreviewProvider {
    static var previews: some View {
        EditDocumentationView()
    }
}
