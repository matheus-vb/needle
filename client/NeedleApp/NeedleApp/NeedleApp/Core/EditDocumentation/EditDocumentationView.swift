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
    @StateObject var context = RichTextContext()
    
    @State var data = Data()
    @State var saved : String = ""
    
    @State var selectedOption = NSLocalizedString("Descrição", comment: "")
    var body: some View {
        
        VStack(alignment: .leading){
            HStack{
                editor
                leftBorder
                toolbar
            }
        }
        .frame(minHeight: 600)
        .background(Color.theme.grayBackground)
        .border(Color.theme.blackMain, width: 2)
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
            .foregroundColor(Color.theme.blackMain)
    }
    
    var leftBorder: some View {
        HStack {
           Rectangle()
               .frame(width: 2)
               .foregroundColor(Color.theme.blackMain)
       }
    }
}
