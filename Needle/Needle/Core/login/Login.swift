//
//  Login.swift
//  Needle
//
//  Created by jpcm2 on 30/05/23.
//

import SwiftUI

struct Login: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @StateObject var workspaceViewModel: WorkspaceViewModel = WorkspaceViewModel()
    
    @State var goToWorkspaces = false
    var body: some View {
        GeometryReader{geometry in
            ZStack{
                NavigationLink(destination: WorkspaceView(user: loginViewModel.user ?? User(id: "1", role: "MEMBER", name: "", email: "")).environmentObject(workspaceViewModel).navigationBarBackButtonHidden(true), isActive: $goToWorkspaces, label: {EmptyView()})
                Image("background")
                    .resizable()
                    .scaledToFill()
                Image("needleLogo")
                    .position(x: 80, y: 50)
                VStack(spacing: 77){
                    Spacer()
                    loginTitle
                    textFieldsComponent
                        .padding([.leading, .trailing], 352)
                    Spacer()
                    Spacer()
                }
            }
        }
    }
}
