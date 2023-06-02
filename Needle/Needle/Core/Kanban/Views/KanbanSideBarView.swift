//
//  KanbanSideBarView.swift
//  Needle
//
//  Created by gabrielfelipo on 29/05/23.
//

import SwiftUI

struct KanbanSideBarView: View {
    let workspace: Workspace
    let documentViewModel: DocumentsViewModel
    @Binding var reset: Bool
    
    struct SideBarButtonStyle: ButtonStyle {
        let cor: Color
        
        private var colorBackground: Color {
            return cor == Color.black ? .black : Color.color.kanbanGrayLOWOPACITY
        }
        
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .background(colorBackground)
                .clipShape(Circle())
                
        }
    }
    
    struct HomeButtonStyle: ButtonStyle {
        
        
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .background(.clear)
                
        }
    }
    
    var body: some View {
        VStack{
            Spacer().frame(height: 41)
            
            Text("Needle")
                .font(.custom(.spaceGroteskSemiBold, size: 22))
                .foregroundColor(.black)
            
            Spacer().frame(height: 50)
            Button(action: {
                print("Home")
            }) {
                HStack(spacing: 8){
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 10, height: 20)
                        .foregroundColor(.gray)
                    Text("Home")
                        .font(.custom(.spaceGroteskBold, size: 16))
                        .foregroundColor(.gray)
                }
            }.buttonStyle(HomeButtonStyle())
            
            Spacer().frame(minHeight: 34)
            
            VStack(spacing: 20){
                NavigationLink(destination: CreateTaskView(workspaceId: workspace.id, accessCode: workspace.accessCode), label: {
                    VStack{
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.white)
                        
                    }.frame(width: 46, height: 46)
                }).buttonStyle(SideBarButtonStyle(cor: .black))
                
                Button(action: {
                    print("compartilhei")
                }) {
                    VStack{
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.white)
                        
                    }.frame(width: 46, height: 46)
                }.buttonStyle(SideBarButtonStyle(cor: .black))
                
                Button(action: {
                    reset.toggle()
                }){
                    ZStack{
                        Circle()
                            .strokeBorder(.black, lineWidth: 2)
                            .background(Color.color.backgroundGray)
                            .frame(height: 46)
                        
                        Image(systemName: "gobackward")
                            .resizable()
                            .frame(width: 18, height: 19)
                            .foregroundColor(.black)
                    }
                }.buttonStyle(SideBarButtonStyle(cor: .white))
            }
            
            Spacer().frame(height: 120)
            Spacer()
            
            NavigationLink(destination: DocumentsView(workspace: workspace).environmentObject(documentViewModel), label: {
                VStack{
                    Image(systemName: "doc")
                        .resizable()
                        .frame(width: 16, height: 20)
                        .foregroundColor(.white)
                }.frame(width: 46, height: 46)
            }).buttonStyle(SideBarButtonStyle(cor: .black))
            
//            Button(action: {
//
//            }) {
//                VStack{
//                    Image(systemName: "doc")
//                        .resizable()
//                        .frame(width: 16, height: 20)
//                        .foregroundColor(.white)
//                }.frame(width: 46, height: 46)
//            }.buttonStyle(SideBarButtonStyle(cor: .black))
            
            Spacer().frame(height: 87)
            
        }.frame(width: 170)
            .background(Color.color.backgroundGray)
    }
}
