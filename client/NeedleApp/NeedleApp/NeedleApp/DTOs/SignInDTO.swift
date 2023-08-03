//
//  SignInDTO.swift
//  NeedleApp
//
//  Created by matheusvb on 03/08/23.
//

import Foundation

struct SignInDTO: Codable {
    let userId: String
    let email: String?
    let name: String?
}
