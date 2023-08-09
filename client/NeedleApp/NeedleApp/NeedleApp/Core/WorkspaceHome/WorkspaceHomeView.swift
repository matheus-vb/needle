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
    
    @StateObject var projectViewModel = ProjectViewModel()
    
    @State var isDeleting = false
    @State var isNaming = false
    @State var isJoining = false
    
    @State var accessCode: String?
    
    @State var isAnimating = false
    @State var showMain = false
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let height: CGFloat = 150
    
    var gridHeader: some View {
        VStack(alignment: .leading, spacing: 8){
            Text("Workspaces").font(.custom(SpaceGrotesk.regular.rawValue, size: 40)).foregroundColor(Color.theme.blackMain)
            HStack(spacing: 24) {
                Button("+ Criar"){
                    isNaming.toggle()
                }.buttonStyle(AddWorkspaceButton())
                Button("􀉤 Entrar"){
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
                .environmentObject(projectViewModel)
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
    
    var loading: some View {
        ZStack {
            Image("icon-bg")
                .offset(x: 200, y: 40)
                .blur(radius: 8)
            Circle()
                .trim(from: 0, to: 0.8)
                .stroke(Color.theme.greenMain, lineWidth: 4)
                .frame(width: 50, height: 50)
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .onAppear() {
                    withAnimation (.linear(duration: 1).repeatForever(autoreverses: false)) {
                        self.isAnimating.toggle()
                    }
                }
        }
    }
    
    var main: some View {
        ZStack {
            Image("icon-bg")
                .offset(x: 200, y: 40)
            ScrollView {
                VStack() {
//                    banner
//                    Spacer()
                    VStack(alignment: .leading, spacing: 28){
                        gridHeader
                        workspaceGrid
                    }
                    .padding(.top, 110)
//                    Spacer()
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
    
    var body: some View {
        if showMain {
            main
        } else {
            loading
                .onAppear {
                    Task {
                        await loadData()
                    }
                }
        }
    }
    
    func loadData() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        withAnimation {
            showMain = true
        }
    }
}
