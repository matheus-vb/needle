//
//  popUpButton.swift
//  NeedleApp
//
//  Created by jpcm2 on 07/08/23.
//

import SwiftUI

struct PopUpButton: View {
    let text: String
    var onButtonTapped: () -> Void
    var body: some View {
        Button(action: {
            onButtonTapped()
        }, label:{
            Text(text)
                .padding([.top, .bottom], 9)
                .frame(width: 104)
                .background(text == "Cancelar" ? Color.theme.blackMain : Color.theme.greenMain)
                .foregroundColor(text == "Cancelar" ? Color.white : Color.theme.blackMain)
                .font(.system(size: 12, weight: .regular))
                .cornerRadius(12)
        })
        .buttonStyle(.plain)
    }
}
