//
//  BackButton.swift
//  NeedleApp
//
//  Created by jpcm2 on 09/08/23.
//

import SwiftUI

struct BackButton: View {
    var onButtonTapped: () -> Void
    @State var isPressed: Bool = false
    var body: some View {
        Button(action: {
            isPressed.toggle()
            onButtonTapped()
        }, label: {
            HStack{
                Image(systemName: "chevron.backward.2")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("Voltar")
                    .font(.system(size: 16, weight: .regular))
            }
            .foregroundColor(isPressed ? Color.theme.greenSecondary : Color.theme.grayPressed)
        })
        .buttonStyle(.plain)
    }
}
