//
//  NameWorkspaceSheet.swift
//  NeedleApp
//
//  Created by Bof on 27/07/23.
//

import Foundation
import SwiftUI

struct NameWorkspaceSheet: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var mock: MockWorkspaces
    
    var index: Int
    
    var body: some View {
        VStack(spacing: 24) {
            Text("New Project").font(.title)
            TextField("Name defining", text: $mock.content[index].name)
            HStack {
                Button("Cancelar", action: {
                    mock.content.remove(at: index)
                    dismiss()
                }).buttonStyle(PrimarySheetActionButton())
                Button("Create", action: {
                    dismiss()
                }).buttonStyle(SecondarySheetActionButton())
            }
        }.padding(.horizontal, 40)
        .padding(.vertical, 32)
    }
}

struct NameWorkspaceSheetPreview: PreviewProvider {
    static var previews: some View {
        NameWorkspaceSheet(index: 0).environmentObject(MockWorkspaces())
    }
}
