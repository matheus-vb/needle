//
//  TableView.swift
//  Needle
//
//  Created by jpcm2 on 31/05/23.
//

import SwiftUI

struct TableView: View {
    @Binding var documents: [Document]
    
    var body: some View {
        VStack(spacing: 0){
            TableHeader()
            ScrollView{
                ForEach(documents) { document in
                    DocumentRow(title: document.title, area: document.type, author: document.id ?? "Not defined")
                }
            }
        }
        .cornerRadius(18)
        .background(Color.color.backgroundGray)
        .frame(width: 1107)
    }
}
