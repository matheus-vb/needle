//
//  DropdownButton.swift
//  NeedleApp
//
//  Created by aaav on 08/08/23.
//

import SwiftUI

struct DropdownButton: View {
    let text: String
    var onButtonTapped: () -> Void
    @State var isClicked = false
    var body: some View {
        Button(action: {
            onButtonTapped()
            isClicked.toggle()
        }, label:{
            HStack{
                Text("\(text)")
                .font(.custom("SF Pro", size: 12)
                    .weight(.regular))
                .foregroundColor(.black)
                .padding(.leading, 15)

                Spacer()
                Text(isClicked ? "􀄥" : "􀄧")
                    .padding(.trailing, 15)
            }
            .frame(width: 104, height: 32)
            .background(Color.theme.greenMain)
            .overlay(
              RoundedRectangle(cornerRadius: 6)
                .stroke(.black, lineWidth: 1)
            )
        })
        .buttonStyle(.plain)
    }
}


//struct DropdownButton_Previews: PreviewProvider {
//    static var previews: some View {
//        DropdownButton(text:"Status")
//            .frame(width: 200, height: 200)
//    }
//}

