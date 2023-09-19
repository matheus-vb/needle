//
//  ProjectsViewRightSide.swift
//  NeedleApp
//
//  Created by jpcm2 on 03/08/23.
//

import SwiftUI

extension ProjectView{
    
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
            .modifier(Clickable())
            .keyboardShortcut(projectViewModel.selectedTab == .Kanban ? nil : KeyboardShortcut(.tab, modifiers: .control))
            
            Button(action: {
                print("Documentation Button")
                projectViewModel.selectedTab = .Documentation
            }, label: {
                Text(NSLocalizedString("Documentação", comment: ""))
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
            .modifier(Clickable())
            .keyboardShortcut(projectViewModel.selectedTab == .Documentation ? nil : KeyboardShortcut(.tab, modifiers: .control))
            
            Button(action: {
                print("Information Button")
                projectViewModel.selectedTab = .Information
            }, label: {
                Text(NSLocalizedString("Informação", comment: ""))
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.black)
                    .overlay(
                        Rectangle()
                            .frame(height: 6)
                            .foregroundColor(projectViewModel.selectedTab == .Information ? Color.theme.greenMain: Color.theme.grayBackground)
                            .offset(y: 12)
                        , alignment: .bottom
                    )
            })
            .buttonStyle(.plain)
            .modifier(Clickable())
            .keyboardShortcut(projectViewModel.selectedTab == .Information ? nil : KeyboardShortcut(.tab, modifiers: .control))
        }
    }
    
    var inviteMemberButton: some View {
        CopyClipboardButton(text: projectViewModel.getCode(), isOnCard: false) {
        }

    }

}
