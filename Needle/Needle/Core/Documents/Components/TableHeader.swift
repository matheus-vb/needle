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
            Spacer()
            Text("Task")
                .font(.system(size: 20, weight: .bold))
            Spacer()
            Text("Área")
                .font(.system(size: 20, weight: .bold))
            Spacer()
            Text("Criador")
                .font(.system(size: 20, weight: .bold))
            Spacer()
        }
        .frame(width: 1108, height: 74)
        .background(.black)
    }
}

struct TableHeader_Previews: PreviewProvider {
    static var previews: some View {
        TableHeader()
    }
}
