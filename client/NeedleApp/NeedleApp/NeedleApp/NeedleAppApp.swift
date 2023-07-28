//
//  NeedleAppApp.swift
//  NeedleApp
//
//  Created by jpcm2 on 26/07/23.
//

import SwiftUI

@main
struct NeedleAppApp: App {
    var body: some Scene {
        WindowGroup {
            CreateTaskView()
                .frame(minWidth: 1100, minHeight: 600)
        }
    }
}