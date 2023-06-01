//
//  ContentView.swift
//  Needle
//
//  Created by gabrielfelipo on 24/05/23.
//

import SwiftUI

struct WorkspaceView: View {
    let workspaces: [WorkspaceModel] = []
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
            VStack(spacing: 32.0) {
                HStack {
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
                }
                .padding(.horizontal, 32.0)
                .padding(.top, 32.0)
                VStack(spacing: 28.0) {
                    HStack {
                        Text("Workspaces")
                            .font(.custom(.spaceGrotesk, size: 40))
                            .foregroundColor(.black)
                        Spacer()
                    }
                    HStack {
                        Button {
                            
                        } label: {
                            Text("+")
                                .font(.custom(.spaceGrotesk, size: 24))
                                .foregroundColor(.white)
                        }
                        .buttonStyle(addButtonStyle())
                        Spacer()
                    }
                    /*ScrollView {
                        LazyVGrid(columns: columns, spacing: 20.0) {
                            ForEach(workspaces, id: \.self) { workspace in
                                workspaceCardView(workspace: workspace)
                            }
                        }
                    }*/
                }
                .padding(.horizontal, 216.0)
            }
        }
    }
}

struct WorkspaceView_Previews: PreviewProvider {
    static var previews: some View {
        WorkspaceView()
    }
}
