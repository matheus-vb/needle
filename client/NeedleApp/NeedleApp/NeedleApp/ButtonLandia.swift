//
//  ButtonLandia.swift
//  NeedleApp
//
//  Created by aaav on 09/08/23.
//

import SwiftUI

struct ButtonLandia: View {
    
    @State var selectedOption = "Prioridade"
    
    var body: some View {
        DropdownButton(text: $selectedOption, dropOptions: ["Alta", "Média", "Baixa"]) {
            
        }
    }
}

struct ButtonLandia_Previews: PreviewProvider {
    static var previews: some View {
        ButtonLandia()
    }
}
