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
            Text("Join existing workspace").font(.title)
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
                Button("Cancel", action: {
                    dismiss()
                }).buttonStyle(PrimarySheetActionButton())
                Button("Join", action: {
                    WorkspaceDataService.shared.joinWorkspace(userId: AuthenticationManager.shared.user!.id, accessCode: code, role: selectedRole)
                    
                    dismiss()
                }).buttonStyle(SecondarySheetActionButton())
            }
            Text("Insert the code given to you by your workspace owner.")
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
