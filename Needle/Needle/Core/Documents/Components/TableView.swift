//
//  TableView.swift
//  Needle
//
//  Created by jpcm2 on 31/05/23.
//

import SwiftUI

struct TableView: View {
    var body: some View {
        VStack(spacing: 0){
            TableHeader()
            ScrollView{
                DocumentRow()
                DocumentRow()
                DocumentRow()
                DocumentRow()
                DocumentRow()
            }
        }
        .cornerRadius(18)
        .background(Color.color.backgroundGray)
        .frame(width: 1107, height: 592)
    }
}

struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        TableView()
    }
}
