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
                Text("Excluir projeto?").font(.custom(SpaceGrotesk.bold.rawValue, size: 16))
                Text("Lembre-se, ao excluir um workspace,\nsuas tasks e documentos serão perdidos")
                    .font(.custom(SpaceGrotesk.bold.rawValue, size: 12))
                    .multilineTextAlignment(.center)
            }
            HStack(spacing: 16) {
                
                PopUpButton(text: "Cancelar") {
                    dismiss()
                }
                PopUpButton(text: "Excluir") {
                    WorkspaceDataService.shared.deleteWorkspace(accessCode: viewModel.accessCode!, userId: AuthenticationManager.shared.user!.id)
                    dismiss()
                }
            }
        }.padding(.horizontal, 40)
        .padding(.vertical, 32)
    }
}
