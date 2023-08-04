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
    @EnvironmentObject var viewModel: WorkspaceHomeViewModel

    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 8) {
                Text("Excluir projeto?").font(.title)
                Text("Lembre-se, ao excluir um workspace,\nsuas tasks e documentos serão perdidos")
                    .multilineTextAlignment(.center)
            }
            HStack(spacing: 16) {
                Button("Cancelar") {
                    dismiss()
                }
                    .buttonStyle(PrimarySheetActionButton())
                Button("Excluir") {
                    WorkspaceDataService.shared.deleteWorkspace(accessCode: viewModel.accessCode!, userId: AuthenticationManager.shared.user!.id)
                    dismiss()
                }
                    .buttonStyle(SecondarySheetActionButton())
            }
        }.padding(.horizontal, 40)
        .padding(.vertical, 32)
    }
}
