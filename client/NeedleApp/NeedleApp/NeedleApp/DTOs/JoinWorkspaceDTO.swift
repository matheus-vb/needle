//
//  JoinWorkspaceDTO.swift
//  NeedleApp
//
//  Created by matheusvb on 03/08/23.
//

import Foundation

struct JoinWorkspaceDTO: Codable {
    let userId: String
    let accessCode: String
    let role: String
}
