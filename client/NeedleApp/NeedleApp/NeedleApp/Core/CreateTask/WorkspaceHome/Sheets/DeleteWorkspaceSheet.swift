//
//  DeleteWorkspaceSheet.swift
//  NeedleApp
//
//  Created by Bof on 26/07/23.
//

import Foundation
import SwiftUI

struct DeleteWorkspaceSheet: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var mock: MockWorkspaces
    
    var index: Int

    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 8) {
                Text("Excluir projeto?").font(.title)
                Text("Lembre-se, ao excluir um workspace,\nsuas tasks e documentos serão perdidos")
                    .multilineTextAlignment(.center)
            }
            HStack(spacing: 16) {
                Button("Cancelar") {dismiss()}
                    .buttonStyle(PrimarySheetActionButton())
                Button("Excluir") {mock.content.remove(at: index)
                    dismiss()
                }
                    .buttonStyle(SecondarySheetActionButton())
            }
        }.padding(.horizontal, 40)
        .padding(.vertical, 32)
    }
}
