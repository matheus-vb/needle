//
//  ContentView.swift
//  Needle
//
//  Created by gabrielfelipo on 24/05/23.
//

import SwiftUI

struct WorkspaceView: View {
    @EnvironmentObject var workspaceViewModel: WorkspaceViewModel
    var user: User
    
    let columns = [
        GridItem(.adaptive(minimum: 498, maximum: 498)),
    ]
    
    @State var geometryHeight: Double = 0.0
    
    @State var selectedWorkspce: Workspace?
    
    @State var goToKanban = false
    
    @State var showAdd: Bool = false
    @State var didTapCreate: Bool = false
    @State var workspaceName: String = ""
    
    var body: some View {
        ZStack {
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
                            showAdd.toggle()
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
                                
                                ForEach(workspaceViewModel.workspaces, id: \.self) { workspace in
                                    NavigationLink(destination: KanbanView(kanbanViewModel: KanbanView.KanbanViewModel(workspace: workspace)), label: {
                                        workspaceCardView(workspace: workspace)
                                    })
                                }
                            }
                        }
                    }
                }
            }
            PopUpCreateWorkspaceView(workspaceName: $workspaceName, showPopup: $showAdd, didTapCreate: $didTapCreate)
                            .opacity(showAdd ? 1 : 0)
        }
        .onAppear{
            print(user)
            Task {
                await updateWorkspaces()
            }
        }
        .onChange(of: didTapCreate) { _ in
            Task {
                let workspace = await workspaceViewModel.workspaceService.returnCreatedWorkspace(name: workspaceName, userId: user.id)
                if let created = workspace {
                    workspaceViewModel.workspaces.append(created)
                    showAdd = false
                }
            }
        }
        .background(
            HStack{
                Spacer()
                VStack{
                    Spacer()
                    Image("backgroundIcon")
                }
            }.background(Color.color.backgroundGray))
    }
    
    func updateWorkspaces() async {
        Task {
            workspaceViewModel.workspaces =  await workspaceViewModel.workspaceService.returnWorkspaces(id: user.id)
        }
    }
}
