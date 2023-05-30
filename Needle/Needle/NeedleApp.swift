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
            Login()
                .environmentObject(loginViewModel)
        }
    }
}


