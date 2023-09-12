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
            Text("Projetos")
                .foregroundColor(Color.theme.blackMain)
                .font(Font.custom("SF Pro", size: 16).weight(.semibold))

        }
        .padding(15)
//        .background(onHoverProject ? Color.white.blur(radius: 8, opaque: false) : Color.theme.grayBackground.blur(radius: 8, opaque: false))
//        .cornerRadius(6)
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
        Text("+ Novo projeto")
            .foregroundColor(Color.theme.blackMain)
            .font(Font.custom("SF Pro", size: 16).weight(.regular))
            .padding(.vertical, 10)
            .padding(.leading, 20)
            .scaleEffect(onHoverNewProject ? 1.1 : 0.98)
            .animation(.spring(), value: onHoverNewProject)
            .onTapGesture {
                workspaceViewModel.isNaming.toggle()
            }
            .onHover { Bool in
                onHoverNewProject = Bool
            }
            .sheet(isPresented: $workspaceViewModel.isNaming) {
                SheetView(type: .newWorkspace)
                    .foregroundColor(Color.theme.grayHover)
                    .background(.white)
            }
    }
    
    var projectsList: some View {
        List($projectViewModel.projects, id: \.self) {project in
            ProjectButton(project: project.wrappedValue)
                .listRowInsets(EdgeInsets())
        }
        .frame(height: $projectViewModel.projects.count >= 5 ? 330 : (66 * CGFloat($projectViewModel.projects.count)))
    }
    
}

