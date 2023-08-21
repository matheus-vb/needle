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
    @EnvironmentObject var projectViewModel: ProjectViewModel
    
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

struct AddTaskButtonBackground: ViewModifier {
    @State var isHovered = false
    @EnvironmentObject var projectViewModel: ProjectViewModel
    
    func body(content: Content) -> some View {
        content
            .onHover { inside in
                if inside && !projectViewModel.showPopUp {
                    isHovered = true
                } else if !projectViewModel.showPopUp {
                    isHovered = false
                }
            }
            .onChange(of: projectViewModel.showPopUp, perform: { newValue in
                if newValue == false {
                    isHovered = false
                }
            })
            .background(isHovered ? Color.theme.greenSecondary : Color.theme.greenTertiary)
    }
}

struct GenericButtonBackground: ViewModifier {
    let standardColor : Color
    let hoveredColor : Color
    @State var isHovered = false
    @EnvironmentObject var projectViewModel: ProjectViewModel
    
    func body(content: Content) -> some View {
        content
            .onHover { inside in
                if inside {
                    isHovered = true
                } else {
                    isHovered = false
                }
            }
            .background(isHovered ? hoveredColor : standardColor)
    }
}
