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
            Spacer()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Não deixe uma\nponta solta")
                        .font(.custom(SpaceGrotesk.bold.rawValue, size: 60))
                    SignInWithAppleButton(.continue) { request in
                        request.requestedScopes = [.email, .fullName]
                    } onCompletion: { result in
                        loginPageViewModel.handleResult(result)
                    }
//                    .signInWithAppleButtonStyle(.black)
                    .frame(maxWidth: 300, maxHeight: 45)
                    .modifier(Clickable())
                }
                .padding(50)
                Spacer()
                Image("ilustra_novelo_PEQ")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
            }
            
            Spacer()
            
            HStack {
                VStack(alignment: .leading){
                    HStack{
                        Text("Needle")
                            .font(.custom(SpaceGrotesk.bold.rawValue, size: 32))
                            .padding(.leading, 50)
                        Image("agulha_PEQ")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44)
                    }
                    Text("A cultura de documentação permite que cada projeto seja costurado com maestria, evitando emaranhados e confusões, por isso o Needle veio para estimular o registro e consulta das suas atividades.")
                        .font(.custom(SpaceGrotesk.regular.rawValue, size: 20))
                        .padding(.leading, 50)


                }
                
                Divider()
                HStack{
                    VStack(alignment: .leading) {
                        Text("Projetos e Tarefas")
                            .font(.custom(SpaceGrotesk.regular.rawValue, size: 32))
                        VStack(alignment: .leading, spacing: 20){
                            HStack (spacing: 20) {
                                Text("Product design")
                                    .customTextCard()
                                Text("UI/UX")
                                    .customTextCard()
                            }
                            HStack (spacing: 20){
                                Text("Front-end")
                                    .customTextCard()
                                Text("Back-end")
                                    .customTextCard()
                                Text("Branding")
                                    .customTextCard()
                            }
                        }
                    }
                    .padding(.leading, 25)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxHeight: 250)
        }
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
