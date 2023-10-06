//
//  RootView.swift
//  NeedleApp
//
//  Created by matheusvb on 03/08/23.
//

import SwiftUI

struct RootView: View {

    @ObservedObject var rootViewModel = RootViewModel(manager: AuthenticationManager.shared, notificationDS: NotificationDataService.shared, taskDS: TaskDataService.shared, workspaceDS: WorkspaceDataService.shared)
    @AppStorage("onboard") var isOnboard : Bool = false
    @State var logout: Bool = false
    @Environment(\.dismiss) var dismiss

    init(){
        if (UserDefaults.standard.object(forKey: "onboard") != nil){
            self.isOnboard = false
        }else{
            self.isOnboard = true
            UserDefaults.standard.set(false, forKey: "onboard")
        }
    }
    
    var body: some View {
        mainView
            .sheet(isPresented: $rootViewModel.showErrorSheet, content: {
                SheetView(type: .loginError)
            }) 
    }
    
    var mainView: some View {
        ZStack {
            if rootViewModel.authManager.user == nil || logout {
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
                                    logout.toggle()
                                    rootViewModel.logout()
                                    logout.toggle()
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
