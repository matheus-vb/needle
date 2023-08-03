//
//  RootView.swift
//  NeedleApp
//
//  Created by matheusvb on 03/08/23.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var authManager = AuthenticationManager.shared
    
    var body: some View {
        mainView
    }
    
    var mainView: some View {
        ZStack {
            if authManager.user == nil {
                LoginPageView()
            } else {
                WorkspaceHomeView()
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
