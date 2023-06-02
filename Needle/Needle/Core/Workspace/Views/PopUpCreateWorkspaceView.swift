//
//  PopUpCreatTaskView.swift
//  Needle
//
//  Created by lss8 on 01/06/23.
//

import SwiftUI

struct PopUpCreateWorkspaceView: View {
    @Binding var workspaceName: String
    @Binding var showPopup: Bool
    @Binding var didTapCreate: Bool
    
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            Image.drawings.popUpBG
            
            VStack(spacing: 32) {
                VStack {
                    Text("Novo Projeto")
                        .font(.custom(.spaceGrotesk, size: 22))
                        .foregroundColor(Color.color.mainBlack)
                    TextField("", text: $workspaceName)
                        .font(.custom(.spaceGrotesk, size: 22))
                        .foregroundColor(Color.color.mainBlack)
                        .textFieldStyle(PlainTextFieldStyle())
                        .placeholder(when: workspaceName.isEmpty) {
                            Text("Insira o nome do seu novo projeto")
                                .font(.custom(.spaceGrotesk, size: 22))
                                .foregroundColor(.color.mediumGray)
                        }
                        .frame(width: 348, height: 64)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 3)
                                .frame(width: 368, height: 64)
                                .background(.white)
                        )
                }
                HStack {
                    Button{
                        showPopup.toggle()
                    } label:{
                        Text("Cancelar")
                            .font(.custom(.spaceGrotesk, size: 16))
                            .frame(width: 116, height: 32)
                    }
                    .buttonStyle(initialButtonStyle(fontColor: .white, bgColor: .black))
                    Button{
                        
                    }label: {
                        Text("Criar")
                            .font(.custom(.spaceGrotesk, size: 16))
                            .frame(width: 116, height: 32)
                    }
                    .buttonStyle(initialButtonStyle(fontColor: .black, bgColor: Color.color.mainGreen))
                }
            }
        }
        .frame(width: 488, height: 284)
        .cornerRadius(8)
        .shadow(radius: 8)
    }
}
    
