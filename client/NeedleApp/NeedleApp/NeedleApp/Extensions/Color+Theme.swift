//
//  Color+Theme.swift
//  NeedleApp
//
//  Created by matheusvb on 03/08/23.
//
import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let blackMain = Color("BlackMain")
    let blueKanban = Color("BlueKanban")
    let blueMain = Color("BlueMain")
    let grayBackground = Color("GrayBackground")
    let grayHover = Color("GrayHover")
    let grayPressed = Color("GrayPressed")
    let grayButton = Color("GrayButton")
    let greenKanban = Color("GreenKanban")
    let greenMain = Color("GreenMain")
    let greenSecondary = Color("GreenSecondary")
    let greenTertiary = Color("GreenTertiary")
    let orangeKanban = Color("OrangeKanban")
    let orangeMain = Color("OrangeMain")
    let redMain = Color("RedMain")
}

