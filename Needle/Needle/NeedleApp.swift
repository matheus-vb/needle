//
//  NeedleApp.swift
//  Needle
//
//  Created by gabrielfelipo on 24/05/23.
//

import SwiftUI

@main
struct NeedleApp: App {
    var body: some Scene {
        WindowGroup {
            // Uncoment to kanban home view
            //KanbanView(workspace: WorkspaceModel(id: "1", accessCode: "123", name: "Projeto Teste")).frame(minWidth: 900, minHeight: 570)
            
            // Uncoment to start home view
            HomeView()
        }
    }
}


