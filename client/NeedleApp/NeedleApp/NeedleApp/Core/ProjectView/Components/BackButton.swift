//
//  BackButton.swift
//  NeedleApp
//
//  Created by jpcm2 on 09/08/23.
//

import SwiftUI

struct BackButton: View {
    var onButtonTapped: () -> Void
    var body: some View {
        Button(action: {
            onButtonTapped()
        }, label: {
            HStack{
                Image(systemName: "chevron.backward.2")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text(NSLocalizedString("Voltar", comment: ""))
                    .font(.system(size: 16, weight: .regular))
            }
        })
        .buttonStyle(.plain)
        .modifier(Clickable())
    }
}
