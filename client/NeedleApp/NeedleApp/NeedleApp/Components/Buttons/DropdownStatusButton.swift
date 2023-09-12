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
            HStack{
                Text("\(taskStatus?.displayName ?? "Status")")
                .font(.custom("SF Pro", size: 12)
                    .weight(.regular))
                .foregroundColor(.black)
                .padding(.leading, 10)

                Spacer()
                Text(isClicked ? "􀄥" : "􀄧")
                    .padding(.trailing, 10)
            }
            .frame(width: 140, height: 32)
            .background(Color.theme.greenMain)
            .overlay(
              RoundedRectangle(cornerRadius: 6)
                .stroke(.black, lineWidth: 1)
            )
        })
        .buttonStyle(.plain)
        .popover(isPresented: $isClicked, arrowEdge: .bottom) {
            
            VStack(spacing: 0){
                SecondaryDropdownEnumButton(text: "----------") {
                    taskStatus = nil
                }
                ForEach(dropOptions, id: \.self) { dropOption in
                    SecondaryDropdownEnumButton(text: "\(dropOption.displayName)") {
                        taskStatus = dropOption
                        isClicked.toggle()
                    }
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
            HStack{
                Text("\(taskPriority?.displayName ?? NSLocalizedString("Priority", comment: ""))")
                .font(.custom("SF Pro", size: 12)
                    .weight(.regular))
                .foregroundColor(.black)
                .padding(.leading, 10)

                Spacer()
                Image(systemName: isClicked ? "arrowtriangle.down.fill" : "arrowtriangle.right.fill")
                    .padding(.trailing, 10)
            }
            .frame(width: 140, height: 32)
            .background(Color.theme.greenMain)
            .overlay(
              RoundedRectangle(cornerRadius: 6)
                .stroke(.black, lineWidth: 1)
            )
        })
        .buttonStyle(.plain)
        .popover(isPresented: $isClicked, arrowEdge: .bottom) {
            
            VStack(spacing: 0){
                SecondaryDropdownEnumButton(text: "----------") {
                    taskPriority = nil
                }
                ForEach(dropOptions, id: \.self) { dropOption in
                    SecondaryDropdownEnumButton(text: "\(dropOption.displayName)") {
                        taskPriority = dropOption
                        isClicked.toggle()
                    }
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
            HStack{
                Text("\(taskType?.displayName ?? NSLocalizedString("Área", comment: ""))")
                .font(.custom("SF Pro", size: 12)
                    .weight(.regular))
                .foregroundColor(.black)
                .padding(.leading, 10)

                Spacer()
                Image(systemName: isClicked ? "arrowtriangle.down.fill" : "arrowtriangle.right.fill")
                    .padding(.trailing, 10)
            }
            .frame(width: 140, height: 32)
            .background(Color.theme.greenMain)
            .overlay(
              RoundedRectangle(cornerRadius: 6)
                .stroke(.black, lineWidth: 1)
            )
        })
        .buttonStyle(.plain)
        .popover(isPresented: $isClicked, arrowEdge: .bottom) {
            
            VStack(spacing: 0){
                SecondaryDropdownEnumButton(text: "----------") {
                    taskType = nil
                }
                ForEach(dropOptions, id: \.self) { dropOption in
                    SecondaryDropdownEnumButton(text: "\(dropOption.displayName)") {
                        taskType = dropOption
                        isClicked.toggle()
                    }
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
                .padding([.top, .bottom], 9)
                .frame(width: 140)
                .background(onHover ? Color.theme.greenTertiary : Color.theme.greenMain)
                .foregroundColor(Color.theme.blackMain)
                .onHover { Bool in
                    onHover = Bool
                }
                
        })
        .buttonStyle(.plain)
    }
}

//struct DropdownButton_Previews: PreviewProvider {
//    static var previews: some View {
//        DropdownButton(text:"Status")
//            .frame(width: 200, height: 200)
//    }
//}

