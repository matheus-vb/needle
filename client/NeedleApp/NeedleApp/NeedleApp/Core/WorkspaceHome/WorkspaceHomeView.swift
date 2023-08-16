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
    @ObservedObject var workspaceViewModel = WorkspaceHomeViewModel()
    
    @StateObject var projectViewModel = ProjectViewModel()
    
    @State var isDeleting = false
    @State var isNaming = false
    @State var isJoining = false
    
    @State var accessCode: String?
    
    @State var isAnimating = false
    @State var showMain = false
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let height: CGFloat = 150
    
    var header: some View {
        HStack(alignment: .center, spacing: 184){
            DashedButton(text: workspaceViewModel.selectedTab.buttonTitle, isWorkspace: true, onButtonTapped: {
                workspaceViewModel.selectedTab == .joinedWorkspaces ? isJoining.toggle() : isNaming.toggle()
            })
            Text(workspaceViewModel.selectedTab.headerTitle)
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(Color.theme.blackMain)
                .frame(width: 400)
            RoundedRectangle(cornerRadius: 6)
                .frame(width: 320, height: 40)
        }
    }
    
    var workspaceGrid: some View {
        LazyVGrid(columns: columns, spacing: 48) {
            ForEach(workspaceViewModel.workspaces.indices, id: \.self) { index in
                WorkspaceCardView(workspaceInfo: workspaceViewModel.workspaces[index], action: {
                    workspaceViewModel.accessCode = workspaceViewModel.workspaces[index].accessCode
                    isDeleting.toggle()
                })
                .environmentObject(projectViewModel)
            }
        }
        .frame(width: 1000)
    }
    
    var loading: some View {
        ZStack {
            Image("icon-bg")
                .offset(x: 200, y: 40)
                .blur(radius: 8)
            Circle()
                .trim(from: 0, to: 0.8)
                .stroke(Color.theme.blackMain, lineWidth: 4)
                .frame(width: 50, height: 50)
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .onAppear() {
                    withAnimation (.linear(duration: 1).repeatForever(autoreverses: false)) {
                        self.isAnimating.toggle()
                    }
                }
        }
    }
    
    var myProjects: some View {
        VStack {
            
        }
    }
    
    var joinedProjects: some View {
        VStack {
        }
    }
    
    var main: some View {
        ZStack {
            Image("icon-bg")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 2000, alignment: .bottomTrailing)
            VStack(spacing: 84) {
                pageSelector
                ScrollView {
                    VStack(spacing: 76) {
                        header
                        workspaceGrid
                    }
                }
                
            }
        } .sheet(isPresented: $isJoining) {
            SheetView(type: .joinCode)
                .foregroundColor(Color.theme.grayHover)
                .background(.white)
                .environmentObject(mock)
        }
        .sheet(isPresented: $isNaming) {
            SheetView(type: .newWorkspace)
                .foregroundColor(Color.theme.grayHover)
                .background(.white)
                .environmentObject(mock)
        }
        .sheet(isPresented: $isDeleting) {
            SheetView(type: .deleteWorkspace)
                .foregroundColor(Color.theme.grayHover)
                .background(.white)
                .environmentObject(mock)
                .environmentObject(workspaceViewModel)
        }
    }
//        ZStack {
//            Image("icon-bg")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(maxWidth: 2000, alignment: .bottomTrailing)
//            ScrollView {
//                VStack() {
//                    VStack(alignment: .leading, spacing: 40){
//                        gridHeader
//                        workspaceGrid
//                    }.padding(.top, 80)
//                }.padding(.bottom, 120)
//            }
//        }
//        .sheet(isPresented: $isJoining) {
//            SheetView(type: .joinCode)
//                .foregroundColor(Color.theme.grayHover)
//                .background(.white)
//                .environmentObject(mock)
//        }
//        .sheet(isPresented: $isNaming) {
//            SheetView(type: .newWorkspace)
//                .foregroundColor(Color.theme.grayHover)
//                .background(.white)
//                .environmentObject(mock)
//        }
//        .sheet(isPresented: $isDeleting) {
//            SheetView(type: .deleteWorkspace)
//                .foregroundColor(Color.theme.grayHover)
//                .background(.white)
//                .environmentObject(mock)
//                .environmentObject(viewModel)
//        }
    
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
