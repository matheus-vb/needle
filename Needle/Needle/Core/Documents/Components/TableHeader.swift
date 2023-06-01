//
//  TableHeader.swift
//  Needle
//
//  Created by jpcm2 on 31/05/23.
//

import SwiftUI

struct TableHeader: View {
    var body: some View {
        HStack(){
            Text("Task")
                .font(.system(size: 20, weight: .bold))
            Spacer()
            Spacer()
            Text("Área")
                .font(.system(size: 20, weight: .bold))
            Spacer()
            Spacer()
            Text("Criador")
                .font(.system(size: 20, weight: .bold))
        }
        .padding(.leading, 56)
        .padding(.trailing, 56)
        .frame(width: 1108, height: 74)
        .background(Color.color.mainBlack)
    }
}

struct TableHeader_Previews: PreviewProvider {
    static var previews: some View {
        TableHeader()
    }
}
