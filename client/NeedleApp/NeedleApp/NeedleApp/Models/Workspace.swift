//
//  Workspce.swift
//  Needle
//
//  Created by jpcm2 on 26/07/23.
//

import Foundation

struct Workspace: Identifiable, Equatable, Codable, Hashable {
    var id: String
    var accessCode: String
    var name: String
    var users: [UserRole]
}

struct UserRole: Equatable, Codable, Hashable {
    let userRole: String
}
