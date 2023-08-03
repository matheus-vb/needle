//
//  Workspce.swift
//  Needle
//
//  Created by jpcm2 on 26/07/23.
//

import Foundation

struct Workspace: Identifiable, Equatable, Hashable{
    var id = UUID()
    var accessCode: String = "#F47HS9"
    var name: String = "Workspace title"
}
