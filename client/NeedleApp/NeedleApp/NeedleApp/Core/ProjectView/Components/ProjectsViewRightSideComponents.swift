//
//  ProjectsViewRightSideComponents.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//

import SwiftUI

extension ProjectsViewRightSideComponent{
    
    var topContainer: some View {
        HStack{
            buttonsContainer
            Spacer()
            inviteMemberButton
        }
    }
    var buttonsContainer: some View {
        HStack(spacing: 48){
            Button(action: {
                print("Kanban Button")
                projectViewModel.selectedTab = .Kanban
            }, label: {
                Text("Kanban")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.black)
                    .overlay(
                        Rectangle()
                            .frame(height: 6)
                            .foregroundColor(projectViewModel.selectedTab == .Kanban ? Color.theme.greenMain: Color.theme.grayBackground)
                            .offset(y: 12)
                        , alignment: .bottom
                    )
            })
            .buttonStyle(.plain)
            
            Button(action: {
                print("Documentation Button")
                projectViewModel.selectedTab = .Documentation
            }, label: {
                Text("Documentação")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.black)
                    .overlay(
                        Rectangle()
                            .frame(height: 6)
                            .foregroundColor(projectViewModel.selectedTab == .Documentation ? Color.theme.greenMain: Color.theme.grayBackground)
                            .offset(y: 12)
                        , alignment: .bottom
                    )
            })
            .buttonStyle(.plain)
        }
    }
    
    var inviteMemberButton: some View {
        Button("􀈟 Convidar Membro") {
            projectViewModel.showShareCode.toggle()
            print("oi")
        }
        .buttonStyle(PrimarySheetActionButton())
    }
}
