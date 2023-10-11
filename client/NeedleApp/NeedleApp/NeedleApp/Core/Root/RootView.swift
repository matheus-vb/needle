//
// RootView.swift
// NeedleApp
//
// Created by matheusvb on 03/08/23.
//
import SwiftUI
struct RootView: View {
    @StateObject var rootViewModel = RootViewModel(manager: AuthenticationManager.shared, notificationDS: NotificationDataService.shared, taskDS: TaskDataService.shared, workspaceDS: WorkspaceDataService.shared, userDS: UserDataService.shared)
    
    @State var logout: Bool = false
    @State var deletingAccount: Bool = false
    @AppStorage("onboard") var isOnboard : Bool = false
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
                if(isOnboard){
                    OnboardingView()
                } else {
                    LoginPageView()
                }
            } else {
                AppView()
                    .sheet(isPresented: $deletingAccount) {
                        DeleteAccountSheet(logout: $logout)
                    }
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
                            VStack{
                                HStack{
                                    Text("Sair ")
                                        .font(.custom(SpaceGrotesk.regular.rawValue, size: 14))
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .foregroundColor(Color.theme.blackMain)
                                .onTapGesture {
                                    logout.toggle()
                                    rootViewModel.logout()
                                    logout.toggle()
                                }
                                Rectangle()
                                    .frame(width: 144, height: 1)
                                    .foregroundColor(Color.theme.blackMain)
                                HStack{
                                    Text(NSLocalizedString("Excluir conta", comment: ""))
                                        .font(.custom(SpaceGrotesk.regular.rawValue, size: 14))
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .foregroundColor(Color.theme.blackMain)
                                .onTapGesture {
                                        deletingAccount.toggle()
                                }
                            }
                        }
                        .padding(.trailing, 30)
                        .padding(.leading, 10)
                    }


            }
        }
    }
}






