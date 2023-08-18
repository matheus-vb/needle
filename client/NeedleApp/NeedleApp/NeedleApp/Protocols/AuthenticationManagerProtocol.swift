//
//  AuthenticationServiceProtocol.swift
//  NeedleApp
//
//  Created by matheusvb on 18/08/23.
//

import Foundation

protocol AuthenticationManagerProtocol: ObservableObject {
    func singIn(userId: String, email: String?, name: String?)
    func getRoleInWorkspace(userId: String, workspaceId: String)
}
