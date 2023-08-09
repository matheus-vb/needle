//
//  RootView.swift
//  NeedleApp
//
//  Created by matheusvb on 03/08/23.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var authManager = AuthenticationManager.shared
    @State var notificationIsPresented : Bool = false
    @State var userLogoutIsPresented : Bool = false
    
    @State var showErrorSheet: Bool = false
    
    @StateObject var mock : NotificationList = NotificationList()
    var body: some View {
        mainView
            .sheet(isPresented: $showErrorSheet, content: {
                SheetView(type: .loginError)
            })
            .onChange(of: authManager.errorCount, perform: {_ in
                showErrorSheet.toggle()
            })
    }
    
    var mainView: some View {
        NavigationStack {
            ZStack {
                if authManager.user == nil {
                    LoginPageView()
                } else {
                    WorkspaceHomeView()
                }
            }
        }
        .toolbar{
                Image("icon-horizontal")
                .resizable()
                .scaledToFit()
            Spacer()
            Image(systemName: mock.list.isEmpty ? "bell" : "bell.badge")
                .popover(isPresented: $notificationIsPresented, arrowEdge: .bottom) {
                    NavigationBarView(mock: mock)
                }
                .onTapGesture { notificationIsPresented.toggle() }
            
            Text("Laura Brito \(userLogoutIsPresented ? "􀄥" : "􀰇")")
                .font(.custom(SpaceGrotesk.regular.rawValue, size: 12))
                .onTapGesture{
                userLogoutIsPresented.toggle()
            }
            .popover(isPresented: $userLogoutIsPresented, arrowEdge: .bottom) {
                Button {
                    authManager.user = nil
                } label: {
                    Text("Sair  􀻵")
                        .font(.custom(SpaceGrotesk.regular.rawValue, size: 14))
                    
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.theme.greenMain)
                .foregroundColor(Color.theme.blackMain)
            }
            .padding(.trailing, 30)
            .padding(.leading, 10)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
