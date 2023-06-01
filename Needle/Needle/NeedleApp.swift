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
    @StateObject private var documentsViewModel = DocumentsViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
            }
        }
    }
}


