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
    @StateObject private var registerViewModel = RegisterViewModel()
    @StateObject private var documentsViewModel = DocumentsViewModel()
    var body: some Scene {
        WindowGroup {
            // Uncomment to start in KanbanView
            //KanbanView(workspace: WorkspaceModel(id: "1", accessCode: "123", name: "Projeto Teste")).frame(minWidth: 900, minHeight: 570)
            
            // Uncomment to start in HomeView
            DocumentsView()
                .environmentObject(documentsViewModel)
        }
    }
}


