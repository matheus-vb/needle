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
        case .myWorkspaces: return NSLocalizedString("Meus projetos", comment: "")
        case .joinedWorkspaces: return NSLocalizedString("Projetos que participo", comment: "")
        }
    }
    var buttonTitle: String {
        switch self {
        case .myWorkspaces: return NSLocalizedString("+ Criar projeto", comment: "")
        case .joinedWorkspaces: return NSLocalizedString("# Entrar num projeto", comment: "")
        }
    }
    
}
