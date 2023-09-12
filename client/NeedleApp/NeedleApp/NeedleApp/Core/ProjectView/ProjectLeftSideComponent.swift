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
    @State var feedbackSheet = false
    
    var body: some View {
        VStack(alignment: .leading){
            
            leftSideTitle
            
            List($projectViewModel.projects, id: \.self) {project in
                ProjectButton(project: project.wrappedValue)
                    .listRowInsets(EdgeInsets())
            }
            .frame(height: $projectViewModel.projects.count <= 1 ? 66 : ($projectViewModel.projects.count == 2 ? 132 : 198))
            
            newProject
            
            Spacer()
            
            DashedSmallerButton(text: "Deixe um feedback"){
                feedbackSheet.toggle()
            }.padding(20)
                .sheet(isPresented: $feedbackSheet) {
                    FeedbackSheetView()
                        .foregroundColor(Color.theme.grayHover)
                        .background(.white)
                }
            
        }
    }
    
    func backButton(){
        dismiss()
    }
}

struct FeedbackSheetView: View {
    @Environment(\.dismiss) var dismiss
    @State var comment : String = ""
    var body: some View {
        VStack(spacing: 4) {
            VStack(spacing: 12) {
                Text("Diga-nos o que está achando do Needle!")
                    .font(.custom("SF Pro", size: 16))
                    .bold()
                    .padding(.vertical, 8)
            }
            
            TextField("", text: $comment)
            
            Button("Enviar", action: {
                dismiss()
            }).buttonStyle(PrimarySheetActionButton())
                .padding(.top, 20)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 35.5)
        
        .foregroundColor(.black)
    }
}
