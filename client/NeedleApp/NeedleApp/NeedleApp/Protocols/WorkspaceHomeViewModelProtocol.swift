//
//  WorkspaceHomeViewModelProtocol.swift
//  NeedleApp
//
//  Created by jpcm2 on 19/09/23.
//

import Foundation

protocol WorkspaceHomeViewModelProtocol: ObservableObject {
    var userID: String { get }
    var query: String { get set }
    var searchResults: [Workspace] { get set }
    var workspaces: [Workspace] { get set }
    var accessCode: String? { get set }
    var selectedTab: WorkspaceTab { get set }
    var isDeleting: Bool { get set }
    var isNaming: Bool { get set }
    var isJoining: Bool { get set }
    var isAnimating: Bool { get set }
    var showMain: Bool { get set }

    func loadData() async
    func updateTab()
    func updateQuery()
}
