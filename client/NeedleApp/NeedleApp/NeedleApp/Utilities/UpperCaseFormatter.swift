//
//  UpperCaseFormatter.swift
//  NeedleApp
//
//  Created by matheusvb on 08/08/23.
//

import Foundation

func formatUpperCase(_ string: String) -> String {
    return string
        .replacingOccurrences(of: "_", with: " ")
        .capitalized
}
