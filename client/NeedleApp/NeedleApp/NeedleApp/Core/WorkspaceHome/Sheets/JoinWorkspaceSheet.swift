//
//  JoinWorkspaceSheet.swift
//  NeedleApp
//
//  Created by Bof on 03/08/23.
//

import Foundation
import SwiftUI

struct JoinWorkspaceSheet: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var mock: MockWorkspaces
    @EnvironmentObject var manager: AuthenticationManager

    @State var code: String = ""
    @State var selectedRole: Role = .DEVELOPER
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Entrar em um workspace existente").font(.custom(SpaceGrotesk.bold.rawValue, size: 16))
            HStack {
                Text("#").font(.title)
                TextField("_ _ _ _ _ _", text: $code).frame(width:100)
            }
            
            Picker("Select a Role", selection: $selectedRole) {
                ForEach(Role.allCases.filter{ $0 != .PRODUCT_MANAGER }) { role in
                    Text(role.displayName).tag(role)
                }
            }
            
            
            HStack {
                PopUpButton(text: "Cancelar") {
                    dismiss()
                }
                PopUpButton(text: "Entrar") {
                    WorkspaceDataService.shared.joinWorkspace(userId: AuthenticationManager.shared.user!.id, accessCode: code)
                    
                    dismiss()
                }            }
            Text("Insira o código fornecido pelo dono do workspace.").font(.custom(SpaceGrotesk.regular.rawValue, size: 12))
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 32)
    }
}

struct JoinWorkspaceSheet_Previews: PreviewProvider {
    static var previews: some View {
        JoinWorkspaceSheet()
    }
}
