//
//  DropdownEnumButton.swift
//  NeedleApp
//
//  Created by aaav on 08/08/23.
//

import SwiftUI

struct DropdownStatusButton: View {
    @Binding var taskStatus : TaskStatus?
    let dropOptions : [TaskStatus]
    var onButtonTapped: () -> Void
    @State var isClicked = false
    var body: some View {
        Button(action: {
            onButtonTapped()
            isClicked.toggle()
        }, label:{
            HStack(spacing: 0){
                Spacer()
                Text("\(NSLocalizedString("Área:", comment: ""))")
                    .padding(.trailing, 4)
                    .font(.custom("SF Pro", size: 12)
                        .weight(.semibold))
                    .foregroundColor(Color.theme.grayPressed)
                
                Text("\(taskStatus?.displayName ?? NSLocalizedString("Selecione", comment: ""))")
                    .font(.custom("SF Pro", size: 12)
                        .weight(.semibold))
                    .foregroundColor(Color.theme.grayButton)
                Image(systemName: isClicked ? "chevron.down" : "chevron.right")
                    .frame(width: 10)
                    .padding(.leading, 4)
                Spacer()
            }
            .frame(width: 170, height: 24)
            .padding(.horizontal, 2)
            .background(Color.theme.grayBackground)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.theme.grayButton, lineWidth: 1)
            )
        })
        .buttonStyle(.plain)
        .popover(isPresented: $isClicked, arrowEdge: .bottom) {
            VStack(spacing: 0){
                SecondaryDropdownEnumButton(text: NSLocalizedString("Selecione", comment: "")) {
                    taskStatus = nil
                }
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.theme.grayPressed)
                ForEach(dropOptions, id: \.self) { dropOption in
                    SecondaryDropdownEnumButton(text: "\(dropOption.displayName)") {
                        taskStatus = dropOption
                        isClicked = false
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.theme.grayButton)
                }
            }
        }
        .modifier(Clickable())
    }
}


struct DropdownPriorityButton: View {
    @Binding var taskPriority : TaskPriority?
    let dropOptions : [TaskPriority]
    var onButtonTapped: () -> Void
    @State var isClicked = false
    var body: some View {
        Button(action: {
            onButtonTapped()
            isClicked.toggle()
        }, label:{
            HStack(spacing: 0){
                Spacer()
                Text("\(NSLocalizedString("Área:", comment: ""))")
                    .padding(.trailing, 4)
                    .font(.custom("SF Pro", size: 12)
                        .weight(.semibold))
                    .foregroundColor(Color.theme.grayPressed)
                
                Text("\(taskPriority?.displayName ?? NSLocalizedString("Selecione", comment: ""))")
                    .font(.custom("SF Pro", size: 12)
                        .weight(.semibold))
                    .foregroundColor(Color.theme.grayButton)
                Image(systemName: isClicked ? "chevron.down" : "chevron.right")
                    .frame(width: 10)
                    .padding(.leading, 4)
                Spacer()
            }
            .frame(width: 170, height: 24)
            .padding(.horizontal, 2)
            .background(Color.theme.grayBackground)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.theme.grayButton, lineWidth: 1)
            )
        })
        .buttonStyle(.plain)
        .popover(isPresented: $isClicked, arrowEdge: .bottom) {
            VStack(spacing: 0){
                SecondaryDropdownEnumButton(text: NSLocalizedString("Selecione", comment: "")) {
                    taskPriority = nil
                }
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.theme.grayPressed)
                ForEach(dropOptions, id: \.self) { dropOption in
                    SecondaryDropdownEnumButton(text: "\(dropOption.displayName)") {
                        taskPriority = dropOption
                        isClicked = false
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.theme.grayButton)
                }
            }
        }
        .modifier(Clickable())
    }
}


struct DropdownTypeButton: View {
    @Binding var taskType : TaskType?
    let dropOptions : [TaskType]
    var onButtonTapped: () -> Void
    @State var isClicked = false
    var body: some View {
        Button(action: {
            onButtonTapped()
            isClicked.toggle()
        }, label:{
            HStack(spacing: 0){
                Spacer()
                Text("\(NSLocalizedString("Área:", comment: ""))")
                    .padding(.trailing, 4)
                    .font(.custom("SF Pro", size: 12)
                        .weight(.semibold))
                    .foregroundColor(Color.theme.grayPressed)
                
                Text("\(taskType?.displayName ?? NSLocalizedString("Selecione", comment: ""))")
                    .font(.custom("SF Pro", size: 12)
                        .weight(.semibold))
                    .foregroundColor(Color.theme.grayButton)
                Image(systemName: isClicked ? "chevron.down" : "chevron.right")
                    .frame(width: 10)
                    .padding(.leading, 4)
                Spacer()
            }
            .frame(width: 170, height: 24)
            .padding(.horizontal, 2)
            .background(Color.theme.grayBackground)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.theme.grayButton, lineWidth: 1)
            )
        })
        .buttonStyle(.plain)
        .popover(isPresented: $isClicked, arrowEdge: .bottom) {
            VStack(spacing: 0){
                SecondaryDropdownEnumButton(text: NSLocalizedString("Selecione", comment: "")) {
                    taskType = nil
                }
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.theme.grayPressed)
                ForEach(dropOptions, id: \.self) { dropOption in
                    SecondaryDropdownEnumButton(text: "\(dropOption.displayName)") {
                        taskType = dropOption
                        isClicked = false
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.theme.grayButton)
                }
            }
        }
        .modifier(Clickable())
    }
}


struct SecondaryDropdownEnumButton: View {
    let text: String
    @State var onHover = false
    var onButtonTapped: () -> Void
    var body: some View {
        Button(action: {
            onButtonTapped()
        }, label:{
            Text(text)
                .font(.custom("SF Pro", size: 12)
                    .weight(.semibold))
                .padding([.top, .bottom], 9)
                .frame(width: 183, height: 24)
                .background(onHover ? Color.theme.greenTertiary : Color.theme.grayBackground)
                .foregroundColor(Color.theme.grayButton)
                .onHover { Bool in
                    onHover = Bool
                }
        })
        .buttonStyle(.plain)
    }
}
