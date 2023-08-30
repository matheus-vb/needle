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
        case .myWorkspaces: return "Meus projetos"
        case .joinedWorkspaces: return "Projetos que participo"
        }
    }
    var buttonTitle: String {
        switch self {
        case .myWorkspaces: return "+ Criar projeto"
        case .joinedWorkspaces: return "# Entrar num projeto"
        }
    }
    
}
