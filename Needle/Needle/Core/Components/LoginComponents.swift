//
//  LoginComponents.swift
//  Needle
//
//  Created by lss8 on 26/05/23.
//

import SwiftUI

extension LoginView {
    
struct tagView: View {
    let name: String
    
    var body: some View {
        Text(name)
            .font(.custom(.spaceGrotesk, size: 24))
            .foregroundColor(.black)
            .padding(.horizontal, 16.0)
            .padding(.vertical, 4.0)
            .background(
                RoundedRectangle(cornerRadius: 4, style: .circular)
                    .fill(Color.color.kanbanGray)
            )
    }
}

struct initialButtonStyle: ButtonStyle {
    let fontColor: Color
    let bgColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(fontColor)
            .background(bgColor)
            .cornerRadius(8)
    }
}

    
struct loginButtonStyle: View {
        
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4, style: .circular)
                .fill(Color.black)
            Text("Entrar")
                .font(.custom(.spaceGrotesk, size: 24))
                .foregroundColor(.white)
                .padding(.vertical, 16.0)
        }
        .frame(width: 213, height: 63)
        
    }
}
    
}
