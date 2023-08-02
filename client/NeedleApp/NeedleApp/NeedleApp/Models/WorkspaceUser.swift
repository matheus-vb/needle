//
//  WorkspaceUser.swift
//  NeedleApp
//
//  Created by jpcm2 on 02/08/23.
//

import Foundation

struct WorkspaceUser: Codable, Identifiable, Hashable{
    var id = UUID()
    let name: String
}
