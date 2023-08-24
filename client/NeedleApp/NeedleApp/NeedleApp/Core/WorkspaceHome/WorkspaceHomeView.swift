//
//  ContentView.swift
//  develop
//
//  Created by Bof on 26/07/23.
//

import SwiftUI
import CoreData

<<<<<<< HEAD
enum WorkspaceTab {
    case myWorkspaces, joinedWorkspaces
    
    var headerTitle: String {
        switch self {
        case .myWorkspaces: return "Meus workspaces"
        case .joinedWorkspaces: return "Workspaces que participo"
        }
    }
    var buttonTitle: String {
        switch self {
        case .myWorkspaces: return "+ Criar workspace"
        case .joinedWorkspaces: return "Participar de workspace"
        }
    }
    
}

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
=======
struct WorkspaceHomeView: View {
    @ObservedObject var workspaceViewModel = WorkspaceHomeViewModel(workspaceDS: WorkspaceDataService.shared)
>>>>>>> 7ed7254545c4c2322073ac064ab798beddb5a0bf
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let height: CGFloat = 150
    
<<<<<<< HEAD
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
=======
    var gridHeader: some View {
        VStack(alignment: .leading, spacing: 28){
            Text("Workspaces").font(.custom(SpaceGrotesk.regular.rawValue, size: 40)).foregroundColor(Color.theme.blackMain)
            HStack(spacing: 32) {
                Button("+ Criar novo workspace"){
                    workspaceViewModel.isNaming.toggle()
                }.buttonStyle(AddWorkspaceButton())
                Button(action: {
                    workspaceViewModel.isJoining.toggle()
                }, label: {
                    HStack {
                        Image(systemName: "personalhotspot")
                        Text("Participar de workspace")
                    }
                })
                .buttonStyle(JoinWorkspaceButton())
            }
>>>>>>> 7ed7254545c4c2322073ac064ab798beddb5a0bf
        }
    }
    
    var workspaceGrid: some View {
<<<<<<< HEAD
        LazyVGrid(columns: columns, spacing: 48) {
            ForEach(workspaceViewModel.workspaces.indices, id: \.self) { index in
                WorkspaceCardView(workspaceInfo: workspaceViewModel.workspaces[index], action: {
                    workspaceViewModel.accessCode = workspaceViewModel.workspaces[index].accessCode
                    isDeleting.toggle()
=======
        LazyVGrid(columns: columns, spacing: 24) {
            ForEach(workspaceViewModel.workspaces.indices, id: \.self) { index in
                WorkspaceCardView(workspace: workspaceViewModel.workspaces[index], action: {
                    workspaceViewModel.accessCode = workspaceViewModel.workspaces[index].accessCode
                    workspaceViewModel.isDeleting.toggle()
>>>>>>> 7ed7254545c4c2322073ac064ab798beddb5a0bf
                })
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
                .rotationEffect(.degrees(workspaceViewModel.isAnimating ? 360 : 0))
                .onAppear() {
                    withAnimation (.linear(duration: 1).repeatForever(autoreverses: false)) {
                        workspaceViewModel.isAnimating.toggle()
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
                    .padding([.top], 64)
                    .padding([.leading, .trailing], 64)
                ScrollView {
                    VStack(spacing: 76) {
                        header
                        workspaceGrid
                    }
                }
                
            }
<<<<<<< HEAD
        } .sheet(isPresented: $isJoining) {
=======
        }
        .sheet(isPresented: $workspaceViewModel.isJoining) {
>>>>>>> 7ed7254545c4c2322073ac064ab798beddb5a0bf
            SheetView(type: .joinCode)
                .foregroundColor(Color.theme.grayHover)
                .background(.white)
        }
        .sheet(isPresented: $workspaceViewModel.isNaming) {
            SheetView(type: .newWorkspace)
                .foregroundColor(Color.theme.grayHover)
                .background(.white)
        }
        .sheet(isPresented: $workspaceViewModel.isDeleting) {
            SheetView(type: .deleteWorkspace)
                .foregroundColor(Color.theme.grayHover)
                .background(.white)
<<<<<<< HEAD
                .environmentObject(mock)
=======
>>>>>>> 7ed7254545c4c2322073ac064ab798beddb5a0bf
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
        if workspaceViewModel.showMain {
            main

        } else {
            loading
                .onAppear {
                    Task {
                        await workspaceViewModel.loadData()
                    }
                }
        }
    }
}

extension WorkspaceHomeView {
    var pageSelector: some View {
        HStack(spacing: 48){
            Button(action: {
                workspaceViewModel.selectedTab = .myWorkspaces
            }, label: {
                Text("Meus projetos")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.black)
                    .overlay(
                        Rectangle()
                            .frame(height: 6)
                            .foregroundColor(workspaceViewModel.selectedTab == .myWorkspaces ? Color.theme.greenMain: Color.theme.grayBackground)
                            .offset(y: 12)
                        , alignment: .bottom
                    )
            })
            .buttonStyle(.plain)
             
            Button(action: {
                workspaceViewModel.selectedTab = .joinedWorkspaces
            }, label: {
                Text("Projetos que participo")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.black)
                    .overlay(
                        Rectangle()
                            .frame(height: 6)
                            .foregroundColor(workspaceViewModel.selectedTab == .joinedWorkspaces ? Color.theme.greenMain: Color.theme.grayBackground)
                            .offset(y: 12)
                        , alignment: .bottom
                    )
            })
            .buttonStyle(.plain)
        }
    }
}
