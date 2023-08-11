//
//  CopyClipboardButton.swift
//  NeedleApp
//
//  Created by aaav on 10/08/23.
//

import SwiftUI

struct CopyClipboardButton: View {
    
    func setTimer() async{
        onTap.toggle()
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        onTap.toggle()
    }
    
    let text: String
    @State var onHover = false
    @State var onTap = false
    
    var onButtonTapped: () -> Void
    var body: some View {
        Button(action: {
            onButtonTapped()
            
            Task{
                await setTimer()

            }
        }, label:{
            HStack{
                Spacer()
                Text("\(text)")
                .font(
                Font.custom("SF Pro", size: 12)
                .weight(.semibold)
                )
                .foregroundColor(.black)
                Spacer()
                Image(systemName: "doc.on.doc")
                .font(
                Font.custom("SF Pro", size:16)
                .weight(.semibold)
                )
                .foregroundColor(.black)
                
            }
            .padding()
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
        .help("Copie o código do projeto para a área de transferência")
        .onHover { Bool in
            onHover = Bool
        }
        .popover(isPresented: $onTap, arrowEdge: .bottom) {
            Text("Código de compartilhamento copiado!")
                .padding()
        }

    }
}


struct CopyClipboardButton_Previews: PreviewProvider {
    static var previews: some View {
        CopyClipboardButton(text: "98889"){}
    }
}
