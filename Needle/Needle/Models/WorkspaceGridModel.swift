//
//  WorkspaceGridModel.swift
//  Needle
//
//  Created by lss8 on 01/06/23.
//

import Foundation

struct WorkspaceGridModel: Identifiable, Codable, Hashable {
    static func == (lhs: WorkspaceGridModel, rhs: WorkspaceGridModel) -> Bool {
        return lhs.id == rhs.id && lhs.accessCode == rhs.accessCode
    }
    
    var id: String
    var accessCode: String
    var name: String
    var owner: String
  
  func hash(into hasher: inout Hasher) {
        hasher.combine(accessCode)
    }
}
