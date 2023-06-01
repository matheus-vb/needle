//
//  Login.swift
//  Needle
//
//  Created by jpcm2 on 30/05/23.
//

import SwiftUI

struct Login: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @State var goToWorkspaces = false
    var body: some View {
        GeometryReader{geometry in
            ZStack{
                NavigationLink(destination: WorkspaceView().navigationBarBackButtonHidden(true), isActive: $goToWorkspaces, label: {EmptyView()})
                Image("background")
                    .resizable()
                    .scaledToFill()
                Image("needleLogo")
                    .offset(x: -geometry.size.width/2 + 75, y: -geometry.size.height/2 - 40)
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
