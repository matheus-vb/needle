//
//  ContentView.swift
//  develop
//
//  Created by Bof on 26/07/23.
//

import SwiftUI
import CoreData

class MockWorkspaces: ObservableObject {
    @Published var content: [Workspace] = [
        
    ]
}

struct WorkspaceHomeView: View {
    @StateObject var mock = MockWorkspaces()
    @ObservedObject var viewModel = WorkspaceHomeViewModel()
    
    @State var isDeleting = false
    @State var isNaming = false
    @State var isJoining = false
    
    @State var accessCode: String?
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let height: CGFloat = 150
    
    var gridHeader: some View {
        VStack(alignment: .leading, spacing: 8){
            Text("Workspaces").font(.largeTitle)
            HStack(spacing: 24) {
                Button("+ Create"){
                    isNaming.toggle()
                }.buttonStyle(AddWorkspaceButton())
                Button("􀉤 Join"){
                    isJoining.toggle()
                }.buttonStyle(JoinWorkspaceButton())
            }
        }
    }
    
    var workspaceGrid: some View {
        LazyVGrid(columns: columns, spacing: 24) {
            ForEach(viewModel.workspaces.indices, id: \.self) { index in
                WorkspaceCardView(workspaceInfo: viewModel.workspaces[index], action: {
                    viewModel.accessCode = viewModel.workspaces[index].accessCode
                    isDeleting.toggle()
                })
            }
        }
        .frame(width: 1000)
    }
    
    
    var banner: some View {
        HStack {
            Image("icon-horizontal")
            Spacer()
            Button(action: {}, label: {Text("logout").foregroundColor(Color.theme.grayHover)})
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
        .sheet(isPresented: $isJoining) {
            JoinWorkspaceSheet()
                .foregroundColor(Color.theme.grayHover)
                .background(.white)
                .environmentObject(mock)
        }
        .foregroundColor(Color.theme.grayHover)
        .background(Color.theme.grayBackground)
        .sheet(isPresented: $isNaming) {
            CreateWorkspaceSheet()
                .foregroundColor(Color.theme.grayHover)
                .background(.white)
                .environmentObject(mock)
        }
        .foregroundColor(Color.theme.grayHover)
        .background(Color.theme.grayBackground)
        .sheet(isPresented: $isDeleting) {
            DeleteWorkspaceSheet()
                .foregroundColor(Color.theme.grayHover)
                .background(.white)
                .environmentObject(mock)
                .environmentObject(viewModel)
        }
        .foregroundColor(Color.theme.grayHover)
        .background(Color.theme.grayBackground)
    }
}
