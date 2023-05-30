//
//  LoginView.swift
//  Needle
//
//  Created by lss8 on 26/05/23.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack {
                HStack {
                    Image.icons.wool
                    Text("Needle")
                        .font(.custom(.spaceGrotesk, size: 19))
                        .foregroundColor(.black)
                }
                HStack {
                    VStack {
                        Text("Não deixe uma ponta solta")
                            .font(.custom(.spaceGrotesk, size: 80))
                            .foregroundColor(.black)
                        HStack {
                            Button {
                                
                            } label: {
                                cadastroButtonView
                            }
                            Button {
                                
                            } label: {
                                loginButtonView
                            }
                        }
                    }
                    Image.drawings.bigWool
                        .resizable()
                        .frame(width: 204, height: 182)
                }
                HStack {
                    VStack {
                        HStack {
                            Text("Needle")
                                .font(.custom(.spaceGrotesk, size: 32))
                                .foregroundColor(.black)
                            Image.icons.needle
                        }
                        Text("A cultura de documentação permite que cada projeto seja costurado com maestria, evitando emaranhados e confusões, por isso o needle, veio para estimular o registro e consulta das suas atividades.")
                            .font(.custom(.spaceGrotesk, size: 24))
                            .foregroundColor(.black)
                    }
                    Divider()
                        .foregroundColor(.black)
                    VStack {
                        Text("Projetos e Terefas")
                        HStack {
                            tagView(name: "Product Design")
                            tagView(name: "UI/UX")
                        }
                        HStack {
                            tagView(name: "Front-end")
                            tagView(name: "Back-end")
                            tagView(name: "Branding")
                        }
                    }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
