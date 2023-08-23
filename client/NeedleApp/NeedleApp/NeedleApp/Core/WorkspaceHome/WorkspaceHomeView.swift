//
//  ContentView.swift
//  develop
//
//  Created by Bof on 26/07/23.
//

import SwiftUI
import CoreData

struct WorkspaceHomeView: View {
    @ObservedObject var workspaceViewModel = WorkspaceHomeViewModel(workspaceDS: WorkspaceDataService.shared)
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let height: CGFloat = 150
    
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
        }
    }
    
    var workspaceGrid: some View {
        LazyVGrid(columns: columns, spacing: 24) {
            ForEach(workspaceViewModel.workspaces.indices, id: \.self) { index in
                WorkspaceCardView(workspace: workspaceViewModel.workspaces[index], action: {
                    workspaceViewModel.accessCode = workspaceViewModel.workspaces[index].accessCode
                    workspaceViewModel.isDeleting.toggle()
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
    
    var main: some View {
        ZStack {
            Image("icon-bg")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 2000, alignment: .bottomTrailing)
            ScrollView {
                VStack() {
                    VStack(alignment: .leading, spacing: 40){
                        gridHeader
                        workspaceGrid
                    }.padding(.top, 80)
                }.padding(.bottom, 120)
            }
        }
        .sheet(isPresented: $workspaceViewModel.isJoining) {
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
                .environmentObject(workspaceViewModel)
        }
    }
    
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
