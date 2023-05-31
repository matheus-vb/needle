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
}

struct Drawings {
    let bigWool = Image("bigWool")
    let cadastroButton = Image("CadastroButton")
}
