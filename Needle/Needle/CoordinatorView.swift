//
//  CoordinatorView.swift
//  Needle
//
//  Created by jpcm2 on 01/06/23.
//

import SwiftUI

@available(macOS 13.0, *)
struct CoordinatorView: View {
    @StateObject private var coordinator = Coordinator()
    var body: some View {
        NavigationStack(path: $coordinator.path, root: {
            coordinator.build(page: .home)
                .navigationDestination(for: Page.self){page in
                    coordinator.build(page: page)
                }
        }).environmentObject(coordinator)
    }
}
