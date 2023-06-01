//
//  WorkspaceModel.swift
//  Needle
//
//  Created by gabrielfelipo on 24/05/23.
//

import Foundation

struct WorkspaceModel: Identifiable, Codable, Hashable {
    static func == (lhs: WorkspaceModel, rhs: WorkspaceModel) -> Bool {
        return lhs.id == rhs.id && lhs.accessCode == rhs.accessCode
    }
    
    var id: String
    var accessCode: String
    var name: String
    var users: [UserModel]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(accessCode)
    }
    
}



/*
 model Workspace {
   id String @id @default(uuid())
   accessCode String @unique
   name String
   tasks Task[]
   users User_Workspace[]
 }
 */
