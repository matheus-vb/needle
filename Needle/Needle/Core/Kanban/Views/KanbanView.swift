//
//  KanbanView.swift
//  Needle
//
//  Created by gabrielfelipo on 26/05/23.
//

import SwiftUI

struct KanbanView: View {
    @ObservedObject var kanbanViewModel: KanbanViewModel
    @StateObject var documentsViewModel: DocumentsViewModel
    @State var reset: Bool = false
    @State var back: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            HStack(spacing: 0){
                
                KanbanSideBarView(workspace: kanbanViewModel.workspace, documentViewModel: documentsViewModel, reset: $reset, back: $back)
                
                Rectangle().frame(width: 2)
                    .background(Color.color.mainBlack)
                
                
                ScrollView([.horizontal, .vertical]) {
                    
                    
                    ZStack(alignment: .center) {
                        
                        VStack{
                            Spacer().frame(height: pow(32 * (kanbanViewModel.geometryHeight/957), kanbanViewModel.scale))
                            
                            KanbanComponentView(workspaceName: kanbanViewModel.workspace.name, workspaceId: kanbanViewModel.workspace.id, reset: $reset)
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
                    }.buttonStyle(KanbanViewModel.InitialButtonStyle())
                    
                    Spacer().frame(width: 24)
                }
                Spacer()
            }
        }
        .onChange(of: back) { _ in
            dismiss()
        }
    }
}

