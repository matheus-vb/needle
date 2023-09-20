//
//  LeftSideComponents.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//

import SwiftUI

extension ProjectView{
    
    var leftSideTitle: some View {
        HStack{
            Image(systemName: "chevron.backward")
                .resizable()
                .scaledToFit()
                .frame(width: 10)
            Text(NSLocalizedString("Projetos", comment: ""))
                .foregroundColor(Color.theme.blackMain)
                .font(Font.custom("SF Pro", size: 16).weight(.semibold))

        }
        .padding(15)
        .scaleEffect(projectViewModel.onHoverProject ? 1.1 : 0.98)
        .animation(.spring(), value: projectViewModel.onHoverProject)
        .onTapGesture {
            dismiss()
        }
        .onHover { Bool in
            projectViewModel.onHoverProject = Bool
        }
        
    }
    
    var newProject: some View {
        Text(NSLocalizedString("+ Novo projeto", comment: ""))
            .foregroundColor(Color.theme.blackMain)
            .font(Font.custom("SF Pro", size: 16).weight(.regular))
            .padding(.vertical, 10)
            .padding(.leading, 20)
            .scaleEffect(projectViewModel.onHoverNewProject ? 1.1 : 0.98)
            .animation(.spring(), value: projectViewModel.onHoverNewProject)
            .onTapGesture {
                projectViewModel.isNaming.toggle()
            }
            .onHover { Bool in
                projectViewModel.onHoverNewProject = Bool
            }
            .sheet(isPresented: $projectViewModel.isNaming) {
                SheetView(type: .newWorkspace)
                    .foregroundColor(Color.theme.grayHover)
                    .background(.white)
            }
    }
    
    var projectsList: some View {
        List($projectViewModel.projects, id: \.self) {project in
            ProjectButton(project: project.wrappedValue, triggerLoading: $projectViewModel.triggerLoading)
                .listRowInsets(EdgeInsets())
        }
        .frame(height: $projectViewModel.projects.count >= 5 ? 330 : (66 * CGFloat($projectViewModel.projects.count)))

    }
}

