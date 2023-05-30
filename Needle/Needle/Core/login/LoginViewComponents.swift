//
//  LoginViewComponents.swift
//  Needle
//
//  Created by jpcm2 on 30/05/23.
//

import SwiftUI

extension Login{
    
    var emailSection: some View {
        VStack(alignment: .leading, spacing: 16){
            Text("E-mail:")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)
            TextField("Insira seu e-mail", text: $loginViewModel.email)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.gray)
                .overlay(
                    Rectangle()
                        .stroke(Color.black, lineWidth: 2)
                )
        }
    }
    
    var passwordSection: some View {
        VStack(alignment: .leading, spacing: 16){
            Text("Senha: ")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)
            TextField("Insira seu senha", text: $loginViewModel.password)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.gray)
                .overlay(
                    RoundedRectangle(cornerRadius: 1)
                        .stroke(Color.black, lineWidth: 2)
                )
        }
    }
    
    var loginButton: some View {
        Button(action: {
            //acao
        }, label: {
            Text("Enviar")
                //.padding([.leading, .trailing], 54)
               // .padding([.top, .bottom], 12)
        }).buttonStyle(BorderlessButtonStyle())
        .font(.system(size: 18, weight: .regular))
        .foregroundColor(Color.white)
        .frame(width: 528)
        .frame(minHeight: 48)
        .background(Color.black)
        .cornerRadius(16)
    }
}
