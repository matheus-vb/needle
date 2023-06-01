//
//  NeedleApp.swift
//  Needle
//
//  Created by gabrielfelipo on 24/05/23.
//

import SwiftUI

@main
struct NeedleApp: App {
    @StateObject private var documentsViewModel = DocumentsViewModel()
    @StateObject private var kanbanViewModel = KanbanView.KanbanViewModel(workspace: Workspace(id: "1", accessCode: "123", name: "Projeto Teste"))
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
            }
        }
    }
}


