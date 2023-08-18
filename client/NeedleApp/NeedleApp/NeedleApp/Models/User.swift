//
//  User.swift
//  Needle
//
//  Created by jpcm2 on 26/07/23.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let email: String
    let workspaces: [UserWorkspace]?
}

struct UserWorkspace: Codable, Hashable {
    let userRole: Role
}
