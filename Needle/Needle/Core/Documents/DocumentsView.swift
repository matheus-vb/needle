//
//  DocumentsView.swift
//  Needle
//
//  Created by jpcm2 on 31/05/23.
//

import SwiftUI

struct DocumentsView: View {
    @EnvironmentObject var documentsViewModel: DocumentsViewModel
    @State var documents: [Document] = []
    
    @Environment(\.dismiss) var dismiss
    
    let workspace: Workspace
    
    var body: some View {
        HStack{
            VStack{
                Text("Needle")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(Color.color.mainBlack)
                Button(action: {
                    dismiss()
                }, label: {
                    HStack(spacing: 0){
                        Image(systemName: "arrow.left")
                            .foregroundColor(Color.color.mediumGray)
                            .font(.system(size: 14, weight: .bold))
                        Text("voltar")
                            .foregroundColor(Color.color.mediumGray)
                            .font(.system(size: 14, weight: .bold))
                    }
                }).buttonStyle(.borderless)
                .frame(width: 67, height: 20)
                .padding(.top, 52)
                Spacer()
            }
            .padding(.top, 42)
            .frame(width: 168)
            Rectangle().frame(width: 2)
                .foregroundColor(.gray)
            Spacer()
            VStack(alignment: .leading, spacing: 50){
                Text("Documentos")
                    .font(.system(size: 40, weight: .regular))
                    .foregroundColor(Color.color.mainBlack)
                TextField("Procure por nome da task, área e taks", text: $documentsViewModel.searchString)
                    .frame(width: 704, height: 36)
                    .font(.system(size: 18))
                    .background(.gray)
                    .foregroundColor(.black)
                TableView(documents: $documents)
                Spacer()
            }
            .padding(.top, 110)
            .refreshable {
                documents = documentsViewModel.documents ?? []
            }
            Spacer()
        }
        .background(Color.color.backgroundGray)
        .onAppear {
            documentsViewModel.documentService.getWorkspaceDocumentations(workspaceId: workspace.id) { result in
                if let result = result {
                    documents = result
                }
            }
        }
        .onChange(of: documentsViewModel.searchString) { _ in
            documentsViewModel.queryDocuments(accessCode: workspace.accessCode)
            documents = documentsViewModel.documents ?? []
        }
    }
}
