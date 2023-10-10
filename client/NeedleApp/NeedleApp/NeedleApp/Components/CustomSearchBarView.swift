//
//  CustomSearchBarView.swift
//  NeedleApp
//
//  Created by aaav on 03/10/23.
//

import SwiftUI

struct CustomSearchBarView: View {
    @Binding var text : String?
    @State var isEditing : Bool = false
    var body: some View {
        TextField(NSLocalizedString("Procurar por nome, descrição, responsável...", comment: ""), text: $text ?? "")
            .frame(height: 24)
            .frame(maxWidth: 408)
            .padding(.horizontal, 25)
            .padding(.leading, 30)
            .background(.white)
            .cornerRadius(6)
            .padding(.horizontal, 10)
            .shadow(color: Color.theme.grayPressed, radius: 3, x: 3, y: 3)
            .onSubmit {
                self.text = nil
            }
            .modifier(searchFieldModifier())
            .textFieldStyle(PlainTextFieldStyle())
            .overlay(
                HStack {
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .opacity(0.4)
                            .padding(.leading, 10)
                        Rectangle()
                            .opacity(0.4)
                            .frame(width: 1)
                    }
                    .padding(.horizontal, 10)

                    Spacer()
                    if self.text != nil {
                        Button(action: {
                            self.text = nil
                            isEditing = false
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .padding(.trailing, 15)
                                .opacity(0.4)
                        })
                        .buttonStyle(.plain)
                    }
                })    }
}

//struct CustomSearchBarView_Previews: PreviewProvider {
////    @State var text: String? = ""
//    static var previews: some View {
////        CustomSearchBarView(text: $text)
//    }
//}
