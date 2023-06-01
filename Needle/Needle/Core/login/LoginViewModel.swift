//
//  LoginViewModel.swift
//  Needle
//
//  Created by jpcm2 on 30/05/23.
//

import Foundation

class LoginViewModel: ObservableObject{
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var user: User?
    
    let authService = AuthService(baseUrl: _URL)
    let workspacesService = WorkspaceService(baseUrl: _URL)
}
