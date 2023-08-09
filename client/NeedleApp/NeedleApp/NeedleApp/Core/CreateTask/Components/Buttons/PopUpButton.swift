//
//  popUpButton.swift
//  NeedleApp
//
//  Created by jpcm2 on 07/08/23.
//

import SwiftUI

struct PopUpButton: View {
    let text: String
    @State var onHover = false
    var onButtonTapped: () -> Void
    var body: some View {
        Button(action: {
            onButtonTapped()
        }, label:{
            Text(text)
                .padding([.top, .bottom], 9)
                .frame(width: 104)
                .background(text == "Cancelar" || text == "Próximo" || text == "Começar" ? (onHover ? Color.theme.grayHover : Color.theme.blackMain) : (onHover ? Color.theme.greenSecondary : Color.theme.greenMain))
                .foregroundColor(text == "Cancelar"  || text == "Próximo" || text == "Começar"  ? Color.white : Color.theme.blackMain)
                .font(.custom(SpaceGrotesk.regular.rawValue, size: 12))
                .cornerRadius(8)
                
        })
        .buttonStyle(.plain)
        .onHover { Bool in
            onHover = Bool
        }
    }
}
