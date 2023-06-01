//
//  RegisterViewComponents.swift
//  Needle
//
//  Created by jpcm2 on 30/05/23.
//

import Foundation
import SwiftUI

@available(macOS 13.0, *)
extension Register{
    var nameSection: some View {
        VStack(alignment: .leading, spacing: 16){
            Text("Nome completo:")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)
            TextField("Insira seu nome completo", text: $registerViewModel.name)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.gray)
                .overlay(
                    Rectangle()
                        .stroke(Color.black, lineWidth: 2)
                )
        }
    }
    var roleSection: some View {
        VStack(alignment: .leading, spacing: 16){
            Text("Área de atuação:")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)
            TextField("Ex: Desenvolvimento, design", text: $registerViewModel.role)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.gray)
                .overlay(
                    Rectangle()
                        .stroke(Color.black, lineWidth: 2)
                )
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
    var emailSection: some View {
        VStack(alignment: .leading, spacing: 16){
            Text("E-mail:")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)
            TextField("Insira seu e-mail", text: $registerViewModel.email)
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
            TextField("Insira seu senha", text: $registerViewModel.password)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.gray)
                .overlay(
                    RoundedRectangle(cornerRadius: 1)
                        .stroke(Color.black, lineWidth: 2)
                )
        }
    }
    
    var registerTitle: some View{
        VStack(alignment: .center, spacing: 8){
            Text("Cadastre-se")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.black)
            Text("Realize seu cadastro para acessar o needle")
                .font(.system(size: 24, weight: .light))
                .foregroundColor(.black)
        }
    }
    
    var registerButton: some View {
        Button(action: {
            var user: User = User(id: "", role: registerViewModel.role, name: registerViewModel.name, email: registerViewModel.email)
            
            print("IN")
            
            registerViewModel.authService.register(user: user, password: registerViewModel.password) { result in
                if let result {
                    user = result
                }
            }
            
            
        }, label: {
            Text("Entrar")
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
            nameSection
            roleSection
            emailSection
            passwordSection
            registerButton
        }
    }
}


