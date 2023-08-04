//
//  ProjectButton.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//

import SwiftUI

struct ProjectButton: View {
    @EnvironmentObject var projectViewModel: ProjectViewModel
    let project: Workspace
    var body: some View {
        Button(action: {
            print("cliquei em \(project.name)")
            projectViewModel.selectedProject = project
        }, label: {
            Text("\(project.name)")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.black)
                .padding([.leading, .trailing], 14)
                .padding([.top, .bottom], 10)
                .frame(minWidth: 170, maxWidth: 180)
                .background(projectViewModel.selectedProject.accessCode == project.accessCode ? Color.theme.mainGreen : Color.theme.backgroundGray)
        })
        .overlay(
            Rectangle()
                .stroke(style: StrokeStyle(lineWidth: 1))
                .foregroundColor(.black)
        )
        .buttonStyle(.plain)
    }
}
