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
            .modifier(Clickable())
            .keyboardShortcut(projectViewModel.selectedTab == .Information ? KeyboardShortcut(.tab, modifiers: .control) : nil)
            
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
            .keyboardShortcut(projectViewModel.selectedTab == .Kanban ? KeyboardShortcut(.tab, modifiers: .control) : nil)
            
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
            .keyboardShortcut(projectViewModel.selectedTab == .Documentation ? KeyboardShortcut(.tab, modifiers: .control) : nil)
        }
    }
    
    var inviteMemberButton: some View {
        CopyClipboardButton(text: projectViewModel.getCode(), isOnCard: false) {
        }

    }
    
    @ViewBuilder
    func statusTitleLabel(rowName: String, color: Color) -> some View {
        
        HStack{
            Circle()
                .frame(width: 10)
                .foregroundColor(color)
                .cornerRadius(5)
            Spacer()
                .frame(width: 8)
            Text(rowName)
                .font(
                    Font.custom("SF Pro", size: 18)
                        .weight(.medium)
                )
                .foregroundColor(.black)
            Spacer()
        }
        .frame(minWidth: 132)
        .frame(height: 32)
        .cornerRadius(5)
        
    }
}
