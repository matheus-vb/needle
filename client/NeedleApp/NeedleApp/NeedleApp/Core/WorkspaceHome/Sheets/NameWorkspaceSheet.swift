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
    
    @State var index: Int
    @State var projectName: String = ""
    
    var body: some View {
        VStack(spacing: 24) {
            Text("New Project").font(.title)
            TextField("Name defining", text: $projectName)
            HStack {
                Button("Cancelar", action: {
                    dismiss()
//                    mock.content.remove(at: index)
                }).buttonStyle(PrimarySheetActionButton())
                Button("Create", action: {
                    dismiss()
                    let newWorkspace = Workspace(name: projectName)
                    mock.content.append(newWorkspace)
                }).buttonStyle(SecondarySheetActionButton())
            }
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 32)
    }
}

//struct NameWorkspaceSheetPreview: PreviewProvider {
//    static var previews: some View {
//        NameWorkspaceSheet(index: 0).environmentObject(MockWorkspaces())
//    }
//}
