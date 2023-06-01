//
//  PopUpView.swift
//  Needle
//
//  Created by MLaura on 30/05/23.
//

import SwiftUI

struct PopUpView: View {
    let imageName: String
    let titleText: String
    let smallText: String
    let buttonText: String
    
    @State var showButton = true
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            
            VStack(spacing: 16){
                Image(imageName)
                    .resizable()
                    .frame(width: 260, height: 175)
                VStack(spacing: 24.0){
                    VStack(spacing: 8){
                        Text(titleText)
                            .font(.custom(.spaceGrotesk, size: 24))
                        Text(smallText)
                            .font(.custom(.spaceGrotesk, size: 14))
                            .multilineTextAlignment(.center)
                    }
                    HStack(spacing: 16){
                        if showButton {
                            Button{
                                
                            } label:{ Text("Cancelar")
                                    .font(.custom(.spaceGrotesk, size: 16))
                                    .frame(width: 116, height: 32)
                            }
                            .buttonStyle(initialButtonStyle(fontColor: .white, bgColor: .black))
                        }
        
                        Button{
                            
                        }label: { Text(buttonText)
                                .font(.custom(.spaceGrotesk, size: 16))
                                .frame(width: 116, height: 32)
                        }  .buttonStyle(initialButtonStyle(fontColor: .black, bgColor: Color.color.mainGreen))
                    }
                    .padding(.bottom, 32.0)
                }
            }
            .padding([.top, .leading, .trailing], 40.0)

        }
        .frame(width: 340, height: 390)
        .cornerRadius(8)
        .shadow(radius: 8)
        
    }
}

struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpView(imageName: "trashPopUp", titleText: "Excluir Projeto?", smallText: "Lembre-se, ao excluir um workspace suas tasks e documentos serão perdidos", buttonText: "Excluir", showButton: true)
    }
}
