//
//  KanbanView.swift
//  Needle
//
//  Created by gabrielfelipo on 26/05/23.
//

import SwiftUI

struct KanbanView: View {
    @ObservedObject var kanbanViewModel: KanbanViewModel
    
    var body: some View {
        ZStack{
            HStack(spacing: 0){
                
                KanbanSideBarView()
                
                Rectangle().frame(width: 2)
                    .background(Color.color.mainBlack)
                
                
                ScrollView([.horizontal, .vertical]) {
                    
                    
                    ZStack(alignment: .center) {
                        
                        VStack{
                            Spacer().frame(height: pow(32 * (kanbanViewModel.geometryHeight/957), kanbanViewModel.scale))
                            
                            KanbanComponentView(workspaceName: kanbanViewModel.workspace.name)
                        }.background(
                            GeometryReader { geometry in
                                Color.color.backgroundGray
                                    .onAppear(){
                                        kanbanViewModel.geometryHeight = geometry.size.height
                                    }
                            })
                        .scaleEffect(kanbanViewModel.scale)
                        .gesture(kanbanViewModel.magnification)
                        .frame(width: 1180 * kanbanViewModel.scale, alignment: .top )
                        
                        VStack(alignment: .leading){
                        }.frame(height: kanbanViewModel.geometryHeight * kanbanViewModel.scale, alignment: .top)
                    }.padding(.horizontal,70)
                }.background(Color.color.backgroundGray)
            }
            
            VStack{
                Spacer().frame(height: 24)
                HStack{
                    Spacer()
                    
                    Button(action: {
                        print("saí")
                    }) {
                        HStack{
                            Text("logout")
                                .font(.custom(.spaceGroteskBold, size: 13))
                            
                            Image(systemName: "xmark.icloud")
                                .frame(width: 22.46, height: 15.63)
                        }.frame(maxWidth: 114, maxHeight: 53)
                    }.buttonStyle(KanbanView.KanbanViewModel.InitialButtonStyle())
                    
                    Spacer().frame(width: 24)
                }
                Spacer()
            }
        }
    }
}

