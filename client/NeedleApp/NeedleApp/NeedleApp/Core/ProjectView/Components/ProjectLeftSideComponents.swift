//
//  LeftSideComponents.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//

import SwiftUI

extension ProjectLeftSideComponent{
    
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
        .scaleEffect(onHoverProject ? 1.1 : 0.98)
        .animation(.spring(), value: onHoverProject)
        .onTapGesture {
            dismiss()
        }
        .onHover { Bool in
            onHoverProject = Bool
        }
        
    }
    
    var newProject: some View {
        Text(NSLocalizedString("+ Novo projeto", comment: ""))
            .foregroundColor(Color.theme.blackMain)
            .font(Font.custom("SF Pro", size: 16).weight(.regular))
            .padding(.vertical, 10)
            .padding(.leading, 20)
            .scaleEffect(onHoverNewProject ? 1.1 : 0.98)
            .animation(.spring(), value: onHoverNewProject)
            .onTapGesture {
                isNaming.toggle()
            }
            .onHover { Bool in
                onHoverNewProject = Bool
            }
            .sheet(isPresented: $isNaming) {
                SheetView(type: .newWorkspace)
                    .foregroundColor(Color.theme.grayHover)
                    .background(.white)
            }
    }
    
    var projectsList: some View {
        List($projectViewModel.projects, id: \.self) {project in
            ProjectButton(project: project.wrappedValue, triggerLoading: $triggerLoading)
                .listRowInsets(EdgeInsets())
        }
        .frame(height: $projectViewModel.projects.count >= 5 ? 330 : (66 * CGFloat($projectViewModel.projects.count)))

    }
}

