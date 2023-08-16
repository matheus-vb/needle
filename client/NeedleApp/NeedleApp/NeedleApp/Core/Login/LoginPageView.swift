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
    
    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userID") var userID: String = ""
    
    @ObservedObject var viewModel = LoginPageViewModel()
    
    @EnvironmentObject var authService: AuthenticationManager
    
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
                        switch result {
                        case .success(let auth):
                            switch auth.credential {
                            case let authCredential as ASAuthorizationAppleIDCredential:
                                //print(authCredential)
                                let userID = authCredential.user
                                let email = authCredential.email
                                let firstName = authCredential.fullName?.givenName
                                let lastName = authCredential.fullName?.familyName
                                self.email = email ?? ""
                                self.firstName = firstName ?? ""
                                self.lastName = lastName ?? ""
                                self.userID = userID
                                
                                AuthenticationManager.shared.singIn(userId: userID, email: email, name: firstName)
            
                                NotificationDataService.shared.updateDeviceToken(userId: userID)
                                
                                WorkspaceDataService.shared.getUsersWorkspaces(userId: userID)
                                
                                NotificationDataService.shared.getUserNotifications(userId: userID)
                                
                            default:
                                break
                            }
                            
                        case .failure(let error):
                            print(error)
                        }
                    }
                    .signInWithAppleButtonStyle(.black)
                    .frame(width: 300, height: 35)
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
