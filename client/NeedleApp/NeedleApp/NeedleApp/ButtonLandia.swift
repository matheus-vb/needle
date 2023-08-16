//
//  ButtonLandia.swift
//  NeedleApp
//
//  Created by aaav on 09/08/23.
//

import SwiftUI

struct ButtonLandia: View {
    
    @State var selectedOption = "Status"
    
    var body: some View {
        VStack{
            DropdownButton(text: $selectedOption, dropOptions: ["Alta", "Baixo"]) {
                
            }
            
            DashedButton(text:
                            "Dashing"){
                
            }
            DashedSmallerButton(text:
                            "Dashing"){
                
            }
            
            PopUpButton(text: "Cancelar") {
                
            }
            
            ProjectGreenButton(text: "Project"){
                
            }
            
            CopyClipboardButton(text: "Copy") {
                
            }
        }
    }
}

struct ButtonLandia_Previews: PreviewProvider {
    static var previews: some View {
        ButtonLandia()
    }
}
