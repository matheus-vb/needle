//
//  Modifiers.swift
//  NeedleApp
//
//  Created by Jpsmor on 16/08/23.
//

import SwiftUI

struct Clickable: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onHover { inside in
                if inside {
                    NSCursor.pointingHand.push()
                } else {
                    NSCursor.pop()
                }
            }
    }
}

struct TaskCardBackground: ViewModifier {
    @State var isHovered = false
    @EnvironmentObject var projectViewModel: ProjectViewModel<AuthenticationManager, TaskDataService, WorkspaceDataService>
    
    func body(content: Content) -> some View {
        content
            .onHover { inside in
                if inside && !projectViewModel.showEditTaskPopUP {
                    isHovered = true
                } else if !projectViewModel.showEditTaskPopUP {
                    isHovered = false
                }
            }
            .onChange(of: projectViewModel.showEditTaskPopUP, perform: { newValue in
                if newValue == false {
                    isHovered = false
                }
            })
            .background(isHovered ? Color.theme.grayBackground : .white)
    }
}

struct workspaceCardModifier: ViewModifier {
    let standardColor : Color
    let hoveredColor : Color
    @State var isHovered = false
    @EnvironmentObject var projectViewModel: ProjectViewModel<AuthenticationManager, TaskDataService, WorkspaceDataService>
    
    func body(content: Content) -> some View {
        content
            .onHover { inside in
                if inside {
                    isHovered = true
                } else {
                    isHovered = false
                }
            }
            .foregroundColor(isHovered ? hoveredColor : standardColor)
    }
}

struct searchFieldModifier: ViewModifier {
    @FocusState var isFocused : Bool

    func body(content: Content) -> some View {
        content
            .focused($isFocused, key: "f")
    }
}
