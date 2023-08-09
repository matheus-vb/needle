//
//  ProjectButton.swift
//  NeedleApp
//
//  Created by aaav on 09/08/23.
//

import SwiftUI

struct ProjectGreenButton: View {
    let text: String
    @State var onHover = false
    var onButtonTapped: () -> Void
    var body: some View {
        Button(action: {
            onButtonTapped()
        }, label:{
            HStack{
                Text("\(text)")
                .font(
                Font.custom("SF Pro", size: 12)
                .weight(.semibold)
                )
                .foregroundColor(.black)
            }
            .frame(width: 168, height: 48, alignment: .center)
            .background(onHover ? Color.theme.greenSecondary : Color.theme.greenMain)
            .cornerRadius(6)
            .overlay(
              RoundedRectangle(cornerRadius: 6)
                .inset(by: 0.5)
                .stroke(Color.theme.blackMain, style: StrokeStyle(lineWidth: 1))
            )
        })
        .buttonStyle(.plain)
        .onHover { Bool in
            onHover = Bool
        }
    }
}
