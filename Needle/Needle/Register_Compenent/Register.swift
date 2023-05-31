//
//  Register.swift
//  Needle
//
//  Created by jpcm2 on 30/05/23.
//

import SwiftUI

struct Register: View {
    @EnvironmentObject var registerViewModel: RegisterViewModel
    var body: some View {
        GeometryReader{geometry in
            ZStack{
                Image("LoginBG")
                    .resizable()
                    .scaledToFill()
                Image("needleLogo")
                    .offset(x: -geometry.size.width/2 + 75, y: -geometry.size.height/2 - 40)
                VStack(spacing: 77){
                    Spacer()
                    registerTitle
                    textFieldsComponent
                        .padding([.leading, .trailing], 352)
                    Spacer()
                    Spacer()
                }
            }
        }
    }
}
