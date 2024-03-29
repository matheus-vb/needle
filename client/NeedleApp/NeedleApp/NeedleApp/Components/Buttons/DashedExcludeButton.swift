//
//  DashingSmallerButton.swift
//  NeedleApp
//
//  Created by aaav on 09/08/23.
//

import SwiftUI

struct DashedExcludeButton: View {
    let text: String
    @State var onHover = false
    var onButtonTapped: () -> Void
    var body: some View {
        Button(action: {
            onButtonTapped()
        }, label:{
            HStack{
                Text(text)
                .font(
                Font.custom("SF Pro", size: 16)
                    .weight(.regular)
                )
                .foregroundColor(Color.theme.blackMain)
                
                Image(systemName: "trash")
            }
            .frame(width: 168, height: 32, alignment: .center)
            .background(onHover ?  Color.theme.greenTertiary :  Color.theme.greenSecondary)
            .cornerRadius(6)
            .overlay(
              RoundedRectangle(cornerRadius: 6)
                .inset(by: 0.5)
                .stroke(.black, style: StrokeStyle(lineWidth: 1, dash: [6, 6]))
            )
        })
        .buttonStyle(.plain)
        .onHover { Bool in
            self.onHover = Bool
        }
    }
}


//struct DashedButton_Previews: PreviewProvider {
//    static var previews: some View {
//        DashedButton(text:"Adicionar Task")
//    }
//}
