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
    
    @StateObject var mock : NotificationList = NotificationList()
    var body: some View {
        mainView
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
                .onTapGesture{
                userLogoutIsPresented.toggle()
            }
            .popover(isPresented: $userLogoutIsPresented, arrowEdge: .bottom) {
                Button("Sair  􀻵"){
                    authManager.user = nil
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
