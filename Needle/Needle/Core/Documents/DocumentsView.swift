//
//  DocumentsView.swift
//  Needle
//
//  Created by jpcm2 on 31/05/23.
//

import SwiftUI

struct DocumentsView: View {
    @EnvironmentObject var documentsViewModel: DocumentsViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 50){
            Text("Documentos")
                .font(.system(size: 40, weight: .regular))
                .foregroundColor(Color.color.mainBlack)
            TextField("Procure por nome da task, área e taks", text: $documentsViewModel.searchString)
                .frame(width: 704, height: 36)
                .font(.system(size: 18))
                .background(.gray)
                .foregroundColor(.black)
            TableView()
        }
        .background(Color.color.backgroundGray)
    }
}
