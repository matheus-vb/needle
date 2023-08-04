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
                            .foregroundColor(projectViewModel.selectedTab == .Kanban ? Color.theme.mainGreen: Color.theme.backgroundGray)
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
                            .foregroundColor(projectViewModel.selectedTab == .Documentation ? Color.theme.mainGreen: Color.theme.backgroundGray)
                            .offset(y: 12)
                        , alignment: .bottom
                    )
            })
            .buttonStyle(.plain)
        }
    }
    
    var inviteMemberButton: some View {
        Button(action: {
            print("Convidar membro button")
        }, label: {
            HStack(spacing: 8){
                Image("paperplane")
                Text("Convidar Membro")
            }
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.black)
            .padding([.leading, .trailing], 14)
            .padding([.top, .bottom], 10)
            .background(Color.theme.mainGreen)
        })
        .overlay(
            Rectangle()
                .stroke(style: StrokeStyle(lineWidth: 1))
                .foregroundColor(.black)
        )
        .buttonStyle(.plain)
    }
}
