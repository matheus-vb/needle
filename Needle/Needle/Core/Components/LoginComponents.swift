//
//  LoginComponents.swift
//  Needle
//
//  Created by lss8 on 26/05/23.
//

import SwiftUI

extension LoginView {
    
struct tagView: View {
    let name: String
    
    var body: some View {
        Text(name)
            .font(.custom(.spaceGrotesk, size: 24))
            .foregroundColor(.black)
            .fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.center)
            .background(
                RoundedRectangle(cornerRadius: 2, style: .circular)
                    .fill(Color.gray)
            )
    }
}
    
var cadastroButtonView: some View {
    Text("Cadastre-se")
        .font(.custom(.spaceGrotesk, size: 24))
        .foregroundColor(.black)
        .fixedSize(horizontal: false, vertical: true)
        .frame(width: 214, height: 63)
        .multilineTextAlignment(.center)
        .background(
            RoundedRectangle(cornerRadius: 2, style: .circular)
                .fill(Color.green)
        )
}
    
var loginButtonView: some View {
    Text("Entrar")
        .font(.custom(.spaceGrotesk, size: 24))
        .foregroundColor(.white)
        .fixedSize(horizontal: false, vertical: true)
        .frame(width: 214, height: 63)
        .multilineTextAlignment(.center)
        .background(
            RoundedRectangle(cornerRadius: 2, style: .circular)
                .fill(Color.black)
        )
}
    
}
