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
    @StateObject private var documentsViewModel = DocumentsViewModel(workspaceId: "c17985fe-2d27-44d3-a6cc-c2d2029b4e59")

    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
            }
        }
    }
}


