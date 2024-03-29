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
    var users: [PmMember]
}
    
struct PmMember: Equatable, Codable, Hashable, Identifiable{
    let id: String
    let userRole: String
    let userId: String
    let workspaceId: String
    let user: UserInfo
}

struct UserInfo:Codable, Hashable{
    var name: String
}
