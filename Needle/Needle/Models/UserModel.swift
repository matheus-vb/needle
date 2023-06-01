//
//  UserModel.swift
//  Needle
//
//  Created by lss8 on 31/05/23.
//  Created by matheusvb on 31/05/23.
//

import Foundation

struct SingleUserResponse: Codable {
    let data: User
}

struct UserRespoonse: Codable {
    let data: [User]
}

struct User: Codable, Identifiable {
    let id: String
    let role: String
    let name: String
    let email: String
}
