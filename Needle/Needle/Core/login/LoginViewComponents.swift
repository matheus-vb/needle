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
            DispatchQueue.main.async {
                loginViewModel.authService.login(email: loginViewModel.email, password: loginViewModel.password) { result in
                    if let result {
                        loginViewModel.user = result
                        goToWorkspaces.toggle()
                    }
                }                
            }
            
            
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
    
    var textFieldsComponent: some View{
        VStack(alignment: .center, spacing: 40){
            emailSection
            passwordSection
            loginButton
        }
    }
    
    var loginTitle: some View{
        VStack(alignment: .center, spacing: 8){
            Text("Login")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.black)
            Text("Realize login para ter acesso aos seus workspaces")
                .font(.system(size: 24, weight: .light))
                .foregroundColor(.black)
        }
    }
}
