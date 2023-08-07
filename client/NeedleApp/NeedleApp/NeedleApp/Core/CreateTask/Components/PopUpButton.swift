//
//  popUpButton.swift
//  NeedleApp
//
//  Created by jpcm2 on 07/08/23.
//

import SwiftUI

struct PopUpButton: View {
    let text: String
    var body: some View {
        Button(action: {
            print("Ooi")
        }, label:{
            Text(text)
                .padding([.top, .bottom], 9)
                .frame(width: 104)
                .background(text == "Cancelar" ? Color.theme.mainBlack : Color.theme.mainGreen)
                .foregroundColor(text == "Cancelar" ? Color.white : Color.theme.mainBlack)
                .font(.system(size: 12, weight: .regular))
                .cornerRadius(12)
        })
        .buttonStyle(.plain)
    }
}

struct popUpButton_Previews: PreviewProvider {
    static var previews: some View {
        PopUpButton(text: "Criar")
    }
}
