//
//  ContentView.swift
//  Needle
//
//  Created by gabrielfelipo on 24/05/23.
//

import SwiftUI

struct WorkspaceView: View {
    let workspaces: [WorkspaceGridModel] = [WorkspaceGridModel(id: "1", accessCode: "28749", name: "Needle", owner: "Felipo"), WorkspaceGridModel(id: "2", accessCode: "30749", name: "Needle", owner: "Medeiros"), WorkspaceGridModel(id: "3", accessCode: "29749", name: "Needle", owner: "Matheus")]
    
    let columns = [
        GridItem(.adaptive(minimum: 498, maximum: 498)),
    ]
    
    @State var geometryHeight: Double = 0.0
    
    var body: some View {
        
        VStack {
            Spacer().frame(height: 32)
            HStack {
                Spacer().frame(width: 32)
                HStack {
                    Image.icons.wool
                    Text("Needle")
                        .font(.custom(.spaceGrotesk, size: 19))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Button {
                    print("saí")
                } label: {
                    HStack{
                        Text("logout")
                            .font(.system(size: 13,weight: .semibold))
                        
                        Image(systemName: "xmark.icloud")
                            .frame(width: 22.46, height: 15.63)
                    }
                    .frame(maxWidth: 114, maxHeight: 53)
                }
                .buttonStyle(InitialButtonStyle())
                
                Spacer().frame(width: 32)
            }
            
            VStack(spacing: 28.0) {
                HStack {
                    Spacer().frame(minWidth: 32, maxWidth: 256)
                    Text("Workspaces")
                        .font(.custom(.spaceGrotesk, size: 40))
                        .foregroundColor(.black)
                    Spacer().frame(minWidth: 865)
                }
                HStack {
                    Spacer().frame(minWidth: 32, maxWidth: 256)
                    Button {
                        
                    } label: {
                        Text("+")
                            .font(.custom(.spaceGrotesk, size: 24))
                            .foregroundColor(.white)
                    }
                    .buttonStyle(addButtonStyle())
                    Spacer().frame(minWidth: 600)
                }
                HStack{
                    Spacer().frame(width: 41)
                    ScrollView{
                        Spacer().frame(height:24)
                        LazyVGrid(columns: columns, spacing: 20.0) {
                            
                            ForEach(workspaces, id: \.self) { workspace in
                                workspaceCardView(workspace: workspace)
                            }
                        }
                    }
                }
                
                
            }
        }.background(
            HStack{
                Spacer()
                VStack{
                    Spacer()
                    Image("backgroundIcon")
                }
            }.background(Color.color.backgroundGray))
    }
}

struct WorkspaceView_Previews: PreviewProvider {
    static var previews: some View {
        WorkspaceView()
    }
}
