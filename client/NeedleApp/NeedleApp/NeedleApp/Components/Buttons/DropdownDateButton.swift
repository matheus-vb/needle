//
//  DropdownButton.swift
//  NeedleApp
//
//  Created by aaav on 08/08/23.
//

import SwiftUI

struct DropdownDateButton: View {
    @Binding var text: String
    let dropOptions : [String]
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
                .padding(.leading, 10)

                Spacer()
                Image(systemName: isClicked ? "arrowtriangle.down.fill" : "arrowtriangle.right.fill")
                    .padding(.trailing, 10)
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

