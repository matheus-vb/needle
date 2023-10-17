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
                selectedTab = .Kanban
            }, label: {
                Text("Kanban")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.black)
                    .overlay(
                        Rectangle()
                            .frame(height: 6)
                            .foregroundColor(selectedTab == .Kanban ? Color.theme.greenMain: Color.theme.grayBackground)
                            .offset(y: 12)
                        , alignment: .bottom
                    )
            })
            .buttonStyle(.plain)
            .modifier(Clickable())
            .keyboardShortcut(selectedTab == .Information ? KeyboardShortcut(.tab, modifiers: .control) : nil)
            
            Button(action: {
                print("Documentation Button")
                selectedTab = .Documentation
            }, label: {
                Text(NSLocalizedString("Documentação", comment: ""))
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.black)
                    .overlay(
                        Rectangle()
                            .frame(height: 6)
                            .foregroundColor(selectedTab == .Documentation ? Color.theme.greenMain: Color.theme.grayBackground)
                            .offset(y: 12)
                        , alignment: .bottom
                    )
            })
            .buttonStyle(.plain)
            .modifier(Clickable())
            .keyboardShortcut(selectedTab == .Kanban ? KeyboardShortcut(.tab, modifiers: .control) : nil)
            
            Button(action: {
                print("Information Button")
                selectedTab = .Information
            }, label: {
                Text(NSLocalizedString("Informação", comment: ""))
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.black)
                    .overlay(
                        Rectangle()
                            .frame(height: 6)
                            .foregroundColor(selectedTab == .Information ? Color.theme.greenMain: Color.theme.grayBackground)
                            .offset(y: 12)
                        , alignment: .bottom
                    )
            })
            .buttonStyle(.plain)
            .modifier(Clickable())
            .keyboardShortcut(selectedTab == .Documentation ? KeyboardShortcut(.tab, modifiers: .control) : nil)

        }
    }
    
    var inviteMemberButton: some View {
        CopyClipboardButton(backgroundColor: .clear, hoverColor: Color.theme.grayPressed ,text: projectViewModel.getCode(), isOnCard: false) {
        }

    }

}
