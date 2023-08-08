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
    
    
    @StateObject var context = RichTextContext()
    
    @State var data = Data()
    @State var saved : String = ""
    
    @State var selectedOption = "Descrição"
        
    var body: some View {
        
        VStack(alignment: .leading){
            HStack{
                editor
                toolbar
            }
            
            Button("Enviar"){
                do {
                    data = try documentation.richTextData(for: .rtf)
                    let encodedData = data.base64EncodedString(options: .lineLength64Characters)
                    saved = encodedData
                    let data = UpdateDocumentationDTO(id: editTaskViewModel.documentationID, text: encodedData, textString: documentation.string)
                    editTaskViewModel.updateDoc(dataDTO: data)
                } catch {
                    print(error)
                }
            }
        }
        .padding()
    }
}

private extension EditDocumentationView {
    
    var editor: some View {
        RichTextEditor(text: $documentation, context: context) {
            $0.textContentInset = CGSize(width: 10, height: 20)
        }
        .focusedValue(\.richTextContext, context)
    }
    
    var toolbar: some View {
        
        RichTextFormatSidebar(context: context)
            .layoutPriority(-1)
    }
}
