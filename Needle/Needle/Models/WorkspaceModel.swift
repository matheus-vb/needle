//
//  WorkspaceModel.swift
//  Needle
//
//  Created by gabrielfelipo on 24/05/23.
//

import Foundation

    
struct SingleWorkspaceResponse: Codable {
    let data: Workspace
}

struct WorkspaceResponse: Codable {
    let data: [Workspace]
}

struct Workspace: Identifiable, Codable, Hashable {
    var id: String
    var accessCode: String
    var name: String
}
