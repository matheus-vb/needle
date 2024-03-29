//
//  ContentView.swift
//  develop
//
//  Created by Bof on 26/07/23.
//

import SwiftUI
import CoreData
import Firebase

struct WorkspaceHomeView: View {
    @ObservedObject var workspaceViewModel = WorkspaceHomeViewModel(workspaceDS: WorkspaceDataService.shared)
    
    let height: CGFloat = 150
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 24),
        GridItem(.flexible(), spacing: 24),
        GridItem(.flexible(), spacing: 24)
    ]
    
    var main: some View {
        GeometryReader { geometry in
            ZStack {
                HStack {
                    Spacer()
                        .frame(maxWidth: .infinity)
                    Image("Bg_Arte")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                VStack(alignment: .center, spacing: geometry.size.height * 0.094) {
                    pageSelector
                        .frame(height: geometry.size.height * 0.12)
                    header
                        .frame(width: geometry.size.width * 0.83)
                    workspaceGrid
                        .frame(maxWidth: 984)
                }
            } .sheet(isPresented: $workspaceViewModel.isJoining) {
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
    }
    
    var body: some View {
        if workspaceViewModel.showMain {
            main
        }
        else {
            loading
                .onAppear {
                    Task {
                        await workspaceViewModel.loadData()
                    }
                }
        }
    }
}
