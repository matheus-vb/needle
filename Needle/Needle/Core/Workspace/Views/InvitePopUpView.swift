//
//  InvitePopUpView.swift
//  Needle
//
//  Created by MLaura on 31/05/23.
//

import SwiftUI

struct InvitePopUpView: View {
    let code: String = "123"
    
    var body: some View {
     
        ZStack{
            Color.white
                .ignoresSafeArea()
           
            VStack(spacing: 40){
                ZStack{
                     Image.drawings.inviteDrawing
                            .resizable()
                            .frame(width: 260, height: 175)
                    
                    Text("#\(code)")
                        .font(.custom(.spaceGrotesk, size: 24))
                        .foregroundColor(.black)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 5)
                                .frame(width: 250, height: 68)
                                .background(.white)
                        )
                        .offset(x:1 , y: 52 )
                    
                }
                .padding(.top,54)
            
            VStack(spacing: 32){
                VStack(spacing: 8){
                    Text("Compartilhe com o time")
                        .font(.custom(.spaceGrotesk, size: 24))
                    
                    Text("Envie o código do seu workspace para o \n time e alinhe sua equipe")
                        .font(.custom(.spaceGrotesk, size: 14))
                        .multilineTextAlignment(.center)
                }
                HStack(spacing: 16){
                    Button{
                        
                    } label:{ Text("Cancelar")
                            .font(.custom(.spaceGrotesk, size: 16))
                            .frame(width: 116, height: 32)
                    }
                    .buttonStyle(initialButtonStyle(fontColor: .white, bgColor: .black))
                    
                    Button{
                        
                    }label: { Text("Copiar")
                            .font(.custom(.spaceGrotesk, size: 16))
                            .frame(width: 116, height: 32)
                    }  .buttonStyle(initialButtonStyle(fontColor: .black, bgColor: Color.color.mainGreen))
                }
            }
        }
            .padding([.leading, .trailing], 40.0)
            .padding(.bottom, 32.0)
            
        }
        .frame(width: 340, height: 390)
        .cornerRadius(8)
        
        
    }
}

struct InvitePopUpView_Previews: PreviewProvider {
    static var previews: some View {
        InvitePopUpView()
    }
}
