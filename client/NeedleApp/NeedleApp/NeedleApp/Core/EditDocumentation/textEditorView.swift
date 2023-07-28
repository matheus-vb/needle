//
//  textEditorView.swift
//  NeedleApp
//
//  Created by aaav on 28/07/23.
//

import SwiftUI
import RichTextKit

struct textEditorView: View {
    
    @StateObject
    var context = RichTextContext()

    @Binding var documentation : NSAttributedString
    
    var body: some View {
        HStack{
            RichTextEditor(text: $documentation, context: context)
            RichTextFormatSidebar(context: context)
                .frame(minWidth: 200)
                .layoutPriority(-1)
        }
        
    }
}
