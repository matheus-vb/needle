//
//  RootView.swift
//  NeedleApp
//
//  Created by matheusvb on 03/08/23.
//

import SwiftUI

struct RootView: View {

    @StateObject var rootViewModel = RootViewModel(manager: AuthenticationManager.shared, notificationDS: NotificationDataService.shared)
    
    var body: some View {
        mainView
            .sheet(isPresented: $rootViewModel.showErrorSheet, content: {
                SheetView(type: .loginError)
            })
            .onChange(of: rootViewModel.authManager.errorCount, perform: {_ in
                rootViewModel.showErrorSheet.toggle()
            })
    }
    
    var mainView: some View {
        ZStack {
            if rootViewModel.authManager.user == nil {
                LoginPageView()
            } else {
                AppView()
                    .toolbar{
                        Image("icon-horizontal")
                            .resizable()
                            .scaledToFit()
                        Spacer()
                        Image(systemName: rootViewModel.notifications.isEmpty ? "bell" : "bell.badge")
                            .popover(isPresented: $rootViewModel.notificationIsPresented, arrowEdge: .bottom) {
                                NavigationBarView()
                                    .environmentObject(NotificationBarViewModel())
                            }
                            .onTapGesture {
                                rootViewModel.presentNotifications()
                            }
                        HStack {
                            Text("\(rootViewModel.authManager.user?.name ?? "")")
                                .font(.custom(SpaceGrotesk.regular.rawValue, size: 14))
                            Image(systemName: rootViewModel.userLogoutIsPresented ? "arrowtriangle.down.fill" : "arrowtriangle.right.fill")
                        }
                            .onTapGesture{
                                rootViewModel.userLogoutIsPresented.toggle()
                                rootViewModel.fetchNotifications()
                            }
                            .popover(isPresented: $rootViewModel.userLogoutIsPresented, arrowEdge: .bottom) {
                                Button {
                                    rootViewModel.logout()
                                } label: {
                                    HStack{
                                        Text("Sair ")
                                            .font(.custom(SpaceGrotesk.regular.rawValue, size: 14))
                                        Image(systemName: "rectangle.portrait.and.arrow.right")
                                    }
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
