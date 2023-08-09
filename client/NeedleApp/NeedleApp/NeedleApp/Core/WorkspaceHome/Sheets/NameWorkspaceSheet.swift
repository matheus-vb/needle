//
//  NameWorkspaceSheet.swift
//  NeedleApp
//
//  Created by Bof on 27/07/23.
//

import Foundation
import SwiftUI

struct CreateWorkspaceSheet: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var mock: MockWorkspaces
    
    @State var projectName: String = ""
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Novo projeto").font(.custom(SpaceGrotesk.bold.rawValue, size: 16))
            TextField("Definição de nome", text: $projectName)
            HStack {
                PopUpButton(text: "Cancelar"){
                    dismiss()
                }
                PopUpButton(text: "Criar"){
                    WorkspaceDataService.shared.createWorkspace(userId: AuthenticationManager.shared.user!.id, name: projectName)
                    dismiss()
                }
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
