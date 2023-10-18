//
//  DashingSmallerButton.swift
//  NeedleApp
//
//  Created by aaav on 09/08/23.
//

import SwiftUI

struct DashedSmallerButton: View {
    let standardColor : Color
    let hoverColor : Color
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
                .foregroundColor(onHover ? Color.theme.grayHover : .black)
            }
            .frame(width: 168, height: 48, alignment: .center)
            .background(onHover ?  hoverColor :  standardColor)
            .cornerRadius(6)
            .overlay(
              RoundedRectangle(cornerRadius: 6)
                .inset(by: 0.5)
//                .stroke(.black, style: StrokeStyle(lineWidth: 1, dash: [6, 6]))
                .stroke(onHover ? Color.theme.grayHover : .black, style: StrokeStyle(lineWidth: 1))
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
