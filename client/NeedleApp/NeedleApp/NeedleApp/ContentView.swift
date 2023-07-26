//
//  ContentView.swift
//  develop
//
//  Created by Bof on 26/07/23.
//

import SwiftUI
import CoreData

struct MockWorkspaces {
    var content: [Workspace] = [
        Workspace(),
        Workspace()
    ]
}

struct ContentView: View {
    @State var mock = MockWorkspaces()
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let height: CGFloat = 150
    
    var gridHeader: some View {
        VStack(alignment: .leading, spacing: 8){
            Text("Workspaces").font(.largeTitle)
            Button("+"){
                mock.content.append(Workspace())
            }.buttonStyle(AddWorkspaceButton())
        }
    }
    
    var workspaceGrid: some View {
        LazyVGrid(columns: columns, spacing: 24) {
            ForEach(mock.content) { card in
                WorkspaceCardView(workspaceInfo: card, action: {
                    
                    if let index = mock.content.firstIndex(of: card) {
                        mock.content.remove(at: index)
                    }
                })
            }
        }
        .frame(width: 1000)
    }
    
    var banner: some View {
        HStack {
            Image("icon-horizontal")
            Spacer()
            Button(action: {}, label: {Text("logout").foregroundColor(Color("main-grey"))})
        }.padding(36)
    }
    
    var body: some View {
        ZStack {
            Image("icon-bg")
                .offset(x: 200, y: 40)
            ScrollView {
                VStack() {
                    
                    banner
                
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 28){
                        
                        gridHeader
                        workspaceGrid
                    }
                    
                    Spacer()
                }.padding(.bottom, 120)
            }
        }
        .foregroundColor(Color("main-grey"))
        .background(Color("BG"))
    }
}
