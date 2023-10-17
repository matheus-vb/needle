//
//  LoginPageView.swift
//  Needle
//
//  Created by aaav on 26/07/23.
//

import SwiftUI
import AuthenticationServices

struct LoginPageView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var loginPageViewModel = LoginPageViewModel(manager: AuthenticationManager.shared, notificationDS: NotificationDataService.shared, workpaceDS: WorkspaceDataService.shared)
    
    var body: some View {
        VStack {
            
            VStack {
                
                Spacer()
                .frame(maxHeight: .infinity)
                
                Text(NSLocalizedString("Não deixe uma ponta solta", comment: ""))
//                .fixedSize(horizontal: false, vertical: true)
                .font(
                Font.custom("SF Pro", size: 70)
                .weight(.semibold)
                )
                .foregroundColor(.black)
                .padding()
                .frame(maxHeight: .infinity)

                Text(.init(NSLocalizedString("**Needle** veio para estimular o registro e consulta das suas\natividades.", comment: "")))
                .font(
                Font.custom("SF Pro", size: 24)                )
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .frame(maxHeight: .infinity)
                .padding()
            }
            
            HStack {
                Image("IlustraHome")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: .infinity, alignment: .bottomLeading)
                
                VStack {
                    SignInWithAppleButton(.continue) { request in
                        request.requestedScopes = [.email, .fullName]
                    } onCompletion: { result in
                        loginPageViewModel.handleResult(result)
                    }
                    .signInWithAppleButtonStyle(.black)
                    .frame(width: 311, height: 56)
                    .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                    .modifier(Clickable())
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                Image("Ilustra_mulherHome")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: .infinity, alignment: .bottomTrailing)
                
            }

            HStack {
                
                Text(NSLocalizedString("Design", comment: ""))
                .font(
                Font.custom("SF Pro", size: 24)
                .weight(.bold)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                
                Text(NSLocalizedString("Gestão de Projetos", comment: ""))
                .font(
                Font.custom("SF Pro", size: 24)
                .weight(.bold)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                
                Text(NSLocalizedString("Desenvolvimento", comment: ""))
                .font(
                Font.custom("SF Pro", size: 24)
                .weight(.bold)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                
            }
            .frame(maxWidth: .infinity ,maxHeight: 164)
            .background(.black)
        }
        .background(Color.theme.grayBackground)
    }
}


struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}


struct LoginTextCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(SpaceGrotesk.regular.rawValue, size: 20))
            .padding(.horizontal, 20)
            .padding(.vertical, 4)
            .background(Color.theme.grayPressed)
            .cornerRadius(5)
    }
}


extension Text {
    func customTextCard() -> some View {
        self.modifier(LoginTextCardModifier())
    }
}
