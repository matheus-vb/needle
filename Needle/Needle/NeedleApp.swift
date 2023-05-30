//
//  NeedleApp.swift
//  Needle
//
//  Created by gabrielfelipo on 24/05/23.
//

import SwiftUI

@main
struct NeedleApp: App {
    @StateObject private var loginViewModel = LoginViewModel()
    var body: some Scene {
        WindowGroup {
            KanbanView(workspace: WorkspaceModel(id: "1", accessCode: "123", name: "Projeto Teste")).frame(minWidth: 900, minHeight: 570)
        }
    }
}


