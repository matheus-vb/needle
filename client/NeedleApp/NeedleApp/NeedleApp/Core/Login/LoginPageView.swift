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
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Não deixe uma\nponta solta")
                        .font(.largeTitle)
                    SignInWithAppleButton(.continue) { request in
                        request.requestedScopes = [.email, .fullName]
                    } onCompletion: { result in
                        switch result {
                        case .success(let auth):
                            switch auth.credential {
                            case let authCredential as ASAuthorizationAppleIDCredential:
                                print(authCredential)
                                let userID = authCredential.user
                                let email = authCredential.email
                                let firstName = authCredential.fullName?.givenName
                                let lastName = authCredential.fullName?.familyName
                                self.email = email ?? ""
                                self.firstName = firstName ?? ""
                                self.lastName = lastName ?? ""
                                self.userID = userID
                                
                                AuthenticationManager.shared.singIn(userId: userID, email: email, name: firstName)
                                
                                print(userID)
                                print(email)
                                print(firstName)
                                NotificationService.shared.updateDeviceToken(userId: userID)
                                
                                WorkspaceDataService.shared.getUsersWorkspaces(userId: userID)
                                
                            default:
                                break
                            }
                            
                        case .failure(let error):
                            print(error)
                        }
                    }
                    .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
                    .frame(width: 200, height: 35)
                }
                Spacer()
            }
            
            Spacer()
            
            HStack {
                VStack(alignment: .leading){
                    Text("Needle 🪡")
                        .font(.title)
                    Text("A cultura de documentação permite que cada projeto seja costurado com maestria, evitando emaranhados e confusões, por isso o Needle veio para estimular o registro e consulta das suas atividades.")
                }
                
                Divider()
                HStack{
                    VStack(alignment: .leading) {
                        
                        Text("Projetos e Tarefas")
                            .font(.title)
                        VStack(alignment: .leading){
                            HStack {
                                Text("Product design")
                                Text("UI/UX")
                            }
                            HStack{
                                Text("Front-end")
                                Text("Back-end")
                                Text("Branding")
                            }
                        }
                    }
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity)
                
            }
            .frame(maxHeight: 120)
        }
        .padding(.horizontal, 30)
        .padding(.top, 30)
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
