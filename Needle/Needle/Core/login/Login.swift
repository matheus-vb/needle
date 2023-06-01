//
//  Login.swift
//  Needle
//
//  Created by jpcm2 on 30/05/23.
//

import SwiftUI

@available(macOS 13.0, *)
struct Login: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject private var coodinator: Coordinator
    var body: some View {
        GeometryReader{geometry in
            ZStack{
                Image("LoginBG")
                    .resizable()
                    .scaledToFill()
                Image("needleLogo")
                    .offset(x: -geometry.size.width/2 + 75, y: -geometry.size.height/2 - 40)
                VStack(spacing: 77){
                    Spacer()
                    loginTitle
                    textFieldsComponent
                        .padding([.leading, .trailing], 352)
                    Spacer()
                    Spacer()
                }
            }
        }
    }
}
