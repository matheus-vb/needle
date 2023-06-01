//
//  Coordinator.swift
//  Needle
//
//  Created by jpcm2 on 01/06/23.
//

import SwiftUI

enum Page: String, Identifiable{
    case home, login, register
    
    var id: String {
        self.rawValue
    }
}

@available(macOS 13.0, *)
class Coordinator: ObservableObject{
    @Published var path = NavigationPath()
    @Published var page: Page?
    
    @StateObject var loginViewModel = LoginViewModel()
    @StateObject var registerViewModel = RegisterViewModel()
    func push(_ page: Page){
        path.append(page)
    }
    
    func pop(){
        path.removeLast()
    }
    
    func popToRoot(){
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func build(page: Page) -> some View{
        switch page{
        case .login:
            Login()
                .environmentObject(loginViewModel)
        case .register:
            Register()
                .environmentObject(registerViewModel)
        case .home:
            HomeView()
        }
    }
}
