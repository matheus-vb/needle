//
//  LeftSideComponent.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//

import SwiftUI

struct ProjectLeftSideComponent: View {
    @EnvironmentObject var projectViewModel: ProjectViewModel<AuthenticationManager, TaskDataService, WorkspaceDataService>
    @Binding var triggerLoading: Bool
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 75){
            BackButton(onButtonTapped: backButton)
                .padding([.top], 14)
            leftSideTitle
            projectsList
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    
    func backButton(){
        dismiss()
    }
}
