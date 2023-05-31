//
//  DocumentRow.swift
//  Needle
//
//  Created by jpcm2 on 31/05/23.
//

import SwiftUI

struct DocumentRow: View {
    var body: some View {
        HStack(){
            HStack(spacing: 44){
                Image("documentImg")
                    .resizable()
                    .frame(width: 34, height: 40)
                VStack{
                    Text("Project Overview")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(Color.color.mainBlack)
                }
            }
            Spacer()
            Text("Geral")
                .font(.system(size: 18, weight: .regular))
                .foregroundColor(Color.color.mainBlack)
            Spacer()
            Text("Owner Fulano")
                .font(.system(size: 18, weight: .regular))
                .foregroundColor(Color.color.mainBlack)
        }
        .padding(.leading, 56)
        .padding(.trailing, 56)
        .frame(width: 1107, height: 105)
        .background(.white)
    }
}

struct DocumentRow_Previews: PreviewProvider {
    static var previews: some View {
        DocumentRow()
    }
}
