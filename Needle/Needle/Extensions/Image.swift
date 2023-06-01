//
//  Image.swift
//  Needle
//
//  Created by lss8 on 26/05/23.
//

import Foundation
import SwiftUI

extension Image {
    static let icons = Icons()
    static let drawings = Drawings()
}

struct Icons {
    let needle = Image("needle")
    let wool = Image("wool")
    let trash = Image("trash")
    let addButton = Image("addWorkspaceButton")
}

struct Drawings {
    let bigWool = Image("bigWool")
    let background = Image("background")
    let cadastroButton = Image("CadastroButton")
    let trashcanDrawing = Image("trashPopUp")
    let inviteDrawing = Image("invitePopUp")
    let notFoundDrawing = Image("notFoundPopUp")
    let cleanDrawing = Image("cleanPopUp")
}
