//
//  DropdownButton.swift
//  NeedleApp
//
//  Created by aaav on 08/08/23.
//

import SwiftUI

struct DropdownButton: View {
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
                Text(isClicked ? "􀄥" : "􀄧")
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
        .popover(isPresented: $isClicked, arrowEdge: .bottom) {
            
            VStack(spacing: 0){
                ForEach(dropOptions, id: \.self) { dropOption in
                    SecondaryDropdownButton(text: "\(dropOption)") {
                        text = dropOption
                    }
                }
            }
        }
    }
}


struct SecondaryDropdownButton: View {
    let text: String
    @State var onHover = false
    var onButtonTapped: () -> Void
    var body: some View {
        Button(action: {
            onButtonTapped()
        }, label:{
            Text(text)
                .padding([.top, .bottom], 9)
                .frame(width: 104)
                .background(onHover ? Color.theme.greenTertiary : Color.theme.greenMain)
                .foregroundColor(Color.theme.blackMain)
                .onHover { Bool in
                    onHover = Bool
                }
                
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

