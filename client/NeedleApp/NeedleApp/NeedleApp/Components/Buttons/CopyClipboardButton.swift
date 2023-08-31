//
//  CopyClipboardButton.swift
//  NeedleApp
//
//  Created by aaav on 10/08/23.
//

import SwiftUI
import Firebase

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
            
            let pasteBoard = NSPasteboard.general
            pasteBoard.clearContents()
            pasteBoard.setString(self.text, forType: .string)
            
            Task{
                await setTimer()

            }
            Analytics.logEvent(K.copiedJoinCode.rawValue, parameters: nil)
        }, label:{
            HStack{
                Spacer()
                Text("\(text)")
                .font(
                Font.custom("SF Pro", size: 14)
                .weight(.semibold)
                )
                .foregroundColor(.black)
                Spacer()
                Image(systemName: onTap ? "checkmark" : "doc.on.doc")
                    .frame(width: 35, height: 35)
                    .background(onHover ? Color.theme.greenSecondary : Color.theme.greenMain)
                    .cornerRadius(6)

                .font(
                Font.custom("SF Pro", size: 16)
                .weight(.semibold)
                )
                .foregroundColor(.black)
                
            }
            .padding()
//            .frame(maxWidth: 168, idealHeight: 48)
            .frame(width: 140, height: 48)
            .background(Color.theme.greenMain)
            .cornerRadius(6)
            .overlay(
              RoundedRectangle(cornerRadius: 6)
                .inset(by: 0.5)
                .stroke(Color.theme.blackMain, style: StrokeStyle(lineWidth: 1))
            )
        })
        .buttonStyle(.plain)
        .help(NSLocalizedString("Copy the project code to the clipboard.", comment: ""))
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
