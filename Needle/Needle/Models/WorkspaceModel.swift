//
//  WorkspaceModel.swift
//  Needle
//
//  Created by gabrielfelipo on 24/05/23.
//

import Foundation

struct WorkspaceModel: Identifiable, Codable {
    var id: String
    var accessCode: String
    var name: String
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
