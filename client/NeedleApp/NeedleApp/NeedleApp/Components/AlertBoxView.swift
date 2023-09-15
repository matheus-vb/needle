//
//  AlertBoxView.swift
//  NeedleApp
//
//  Created by matheusvb on 09/08/23.
//

import SwiftUI

struct AlertBoxView: View {
    var body: some View {
        ZStack{
            Color.theme.grayBackground
            HStack {
                Image(systemName: "exclamationmark.bubble.fill")
                    .padding()
                Text(NSLocalizedString("Clique duas vezes em uma task para expandir!", comment: ""))
            }
        }
        .frame(width: 240, height: 60)
        .cornerRadius(16)
    }
}
