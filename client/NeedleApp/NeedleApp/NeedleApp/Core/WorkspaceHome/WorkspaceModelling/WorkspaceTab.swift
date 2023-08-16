//
//  WorkspaceTab.swift
//  NeedleApp
//
//  Created by Bof on 16/08/23.
//

import Foundation

enum WorkspaceTab {
    case myWorkspaces, joinedWorkspaces
    
    var headerTitle: String {
        switch self {
        case .myWorkspaces: return "Meus workspaces"
        case .joinedWorkspaces: return "Workspaces que participo"
        }
    }
    var buttonTitle: String {
        switch self {
        case .myWorkspaces: return "+ Criar workspace"
        case .joinedWorkspaces: return "Participar de workspace"
        }
    }
    
}
