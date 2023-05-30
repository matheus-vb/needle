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
                    VStack {
                        HStack {
                            Image.icons.wool
                            Text("Needle")
                                .font(.custom(.spaceGrotesk, size: 19))
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding([.top, .leading], 32.0)
                        Spacer()
                        VStack(spacing: 56.0) {
                            HStack {
                                Text("Não deixe uma ponta solta")
                                    .font(.custom(.spaceGrotesk, size: 80))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            HStack(spacing: 32.0) {
                                Button {
                                    
                                } label: {
                                    Text("Cadastro")
                                        .font(.custom(.spaceGrotesk, size: 24))
                                        .frame(maxWidth: 213, maxHeight: 63)
                                }
                                .buttonStyle(initialButtonStyle(fontColor: .black, bgColor: Color.color.mainGreen))
                                Button {
                                    
                                } label: {
                                    Text("Entrar")
                                        .font(.custom(.spaceGrotesk, size: 24))
                                        .frame(maxWidth: 213, maxHeight: 63)
                                }
                                .buttonStyle(initialButtonStyle(fontColor: .white, bgColor: .black))
                                Spacer()
                            }
                        }
                        .padding(.leading, 96.0)
                        Spacer()
                    }
                    VStack {
                        Image.drawings.bigWool
                            .resizable()
                            .frame(width: 600, height: 540)
                        Spacer()
                    }
                }
                HStack {
                    VStack {
                        HStack(spacing: 24.0) {
                            Text("Needle")
                                .font(.custom(.spaceGrotesk, size: 32))
                                .foregroundColor(.black)
                            Image.icons.needle
                            Spacer()
                        }
                        Text("A cultura de documentação permite que cada projeto seja costurado com maestria, evitando emaranhados e confusões, por isso o needle, veio para estimular o registro e consulta das suas atividades.")
                            .font(.custom(.spaceGrotesk, size: 24))
                            .foregroundColor(.black)
                    }
                    .padding(.leading, 96.0)
                    .padding(.trailing, 40.0)
                    Divider()
                        .frame(height: 250)
                        .foregroundColor(.black)
                    VStack(spacing: 24.0) {
                        HStack {
                            Text("Projetos e Tarefas")
                                .font(.custom(.spaceGrotesk, size: 32.0))
                                .foregroundColor(.black)
                            Spacer()
                        }
                        HStack {
                            tagView(name: "Product Design")
                            tagView(name: "UI/UX")
                            Spacer()
                        }
                        HStack {
                            tagView(name: "Front-end")
                            tagView(name: "Back-end")
                            tagView(name: "Branding")
                            Spacer()
                        }
                    }
                    .padding(.leading, 40.0)
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
