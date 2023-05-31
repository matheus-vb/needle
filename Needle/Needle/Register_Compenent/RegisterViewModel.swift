//
//  RegisterViewModel.swift
//  Needle
//
//  Created by jpcm2 on 30/05/23.
//

import Foundation

class RegisterViewModel: ObservableObject{
    @Published var name: String = ""
    @Published var role: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
}
