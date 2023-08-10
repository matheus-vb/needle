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
    
    @StateObject var notificationViewModel = NotificationBarViewModel()
    
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
        ZStack {
            if authManager.user == nil {
                LoginPageView()
            } else {
                AppView()
                    .toolbar{
                        Image("icon-horizontal")
                            .resizable()
                            .scaledToFit()
                        Spacer()
                        Image(systemName: notificationViewModel.notifications.isEmpty ? "bell" : "bell.badge")
                            .popover(isPresented: $notificationIsPresented, arrowEdge: .bottom) {
                                NavigationBarView()
                                    .environmentObject(notificationViewModel)
                            }
                            .onTapGesture {
                                NotificationDataService.shared.getUserNotifications(userId: AuthenticationManager.shared.user!.id)
                                notificationIsPresented.toggle()
                            }
                        
                        Text("\(authManager.user?.name ?? "") \(userLogoutIsPresented ? "􀄥" : "􀰇")")
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
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
