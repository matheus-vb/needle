//
//  ContentView.swift
//  develop
//
//  Created by Bof on 26/07/23.
//

import SwiftUI
import CoreData

struct WorkspaceHomeView: View {
    @StateObject var mock = MockWorkspaces()
    @ObservedObject var workspaceViewModel = WorkspaceHomeViewModel()
    @ObservedObject var searchViewModel = SearchWorkspaceModel()

    @StateObject var projectViewModel = ProjectViewModel()
    
    // sheets
    @State var isDeleting = false
    @State var isNaming = false
    @State var isJoining = false
    
    // code
    @State var accessCode: String?
    
    // loading
    @State var isAnimating = false
    @State var showMain = false
    
    let height: CGFloat = 150
        
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 24),
        GridItem(.flexible(), spacing: 24),
        GridItem(.flexible(), spacing: 24)
    ]
    
    var main: some View {
        GeometryReader { geometry in
            ZStack {
                Image("icon-bg")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 2000, alignment: .bottomTrailing)
                VStack(alignment: .center, spacing: geometry.size.height * 0.094) {
                    pageSelector
                        .frame(height: geometry.size.height * 0.12)
                    header
                        .frame(width: 984)
                    workspaceGrid
                        .frame(maxWidth: 984)
                    
                    
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
