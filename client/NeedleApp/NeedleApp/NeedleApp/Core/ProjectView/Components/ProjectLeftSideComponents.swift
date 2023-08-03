//
//  LeftSideComponents.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//

import SwiftUI

extension ProjectLeftSideComponent{
    var leftSideTitle: some View {
        HStack(spacing: 8){
            Image("needleLogo")
                .resizable()
                .frame(width: 22, height: 22)
            Text("Needle")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
        }
    }
    
    var projectsList: some View {
        ScrollView{
            VStack(spacing: 24){
                ForEach(projectViewModel.projects, id: \.self){project in
                    ProjectButton(project: project)
                }
            }
        }
    }
}
