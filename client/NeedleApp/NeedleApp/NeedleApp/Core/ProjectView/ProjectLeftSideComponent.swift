//
//  LeftSideComponent.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//

import SwiftUI

struct ProjectLeftSideComponent: View {
    @EnvironmentObject var projectViewModel: ProjectViewModel<AuthenticationManager, TaskDataService, WorkspaceDataService>
    @ObservedObject var workspaceViewModel: WorkspaceHomeViewModel<WorkspaceDataService>
        
    init() {
        self.workspaceViewModel = WorkspaceHomeViewModel(workspaceDS: WorkspaceDataService.shared)
    }
    
    @Environment(\.dismiss) var dismiss
    @State var onHoverProject = false
    @State var onHoverNewProject = false

    var body: some View {
        VStack(alignment: .leading){
            
            HStack{
                Image(systemName: "square.grid.2x2")
                Text("Projetos  ")
                    .font(Font.custom("SF Pro", size: 14).weight(.regular))

            }
            .padding(.vertical, 10)
            .background(onHoverProject ? Color.white.blur(radius: 8, opaque: false) : Color.theme.grayBackground.blur(radius: 8, opaque: false))
            .cornerRadius(6)
            .onTapGesture {
                dismiss()
            }
            .onHover { Bool in
                onHoverProject = Bool
            }
            
            List($projectViewModel.projects, id: \.self) {project in
                    ProjectButton(project: project.wrappedValue)
                        .listRowInsets(EdgeInsets())
            }
            .frame(height: 200)
            
            Text("+ Novo projeto  ")
                .font(Font.custom("SF Pro", size: 14).weight(.regular))
                .padding(.vertical, 10)
                .background(onHoverNewProject ? Color.theme.greenTertiary.blur(radius: 8, opaque: false) : Color.theme.grayBackground.blur(radius: 8, opaque: false))
                .cornerRadius(6)
                .padding(.leading, 20)
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
            Spacer()
            
        }
        .padding(.leading, 10)
        
    }
    
    func backButton(){
        dismiss()
    }
}
