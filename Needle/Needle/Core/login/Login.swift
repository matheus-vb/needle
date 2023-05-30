//
//  Login.swift
//  Needle
//
//  Created by jpcm2 on 30/05/23.
//

import SwiftUI

struct Login: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    var body: some View {
        ZStack{
            Image("LoginBG")
                .resizable()
                .scaledToFill()
            VStack{
                emailSection
                passwordSection
            }
        }
    }
}
