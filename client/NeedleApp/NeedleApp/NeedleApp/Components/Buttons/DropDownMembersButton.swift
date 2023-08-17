//
//  DropDownMembersButton.swift
//  NeedleApp
//
//  Created by vivi on 16/08/23.
//

//import SwiftUI
//
//struct DropDownMembersButton: View {
//    @Binding var taskStatus : [[ProjectViewModel.workspaceMembersProjectViewModel.workspaceID]]
//    let dropOptions : [TaskStatus]
//    var onButtonTapped: () -> Void
//    @State var isClicked = false
//    var body: some View {
//        Button(action: {
//            onButtonTapped()
//            isClicked.toggle()
//        }, label:{
//            HStack{
//                Text("\(taskStatus?.displayName ?? "Status")")
//                    .font(.custom("SF Pro", size: 12)
//                        .weight(.regular))
//                    .foregroundColor(.black)
//                    .padding(.leading, 10)
//                
//                Spacer()
//                Text(isClicked ? "􀄥" : "􀄧")
//                    .padding(.trailing, 10)
//            }
//            .frame(width: 140, height: 32)
//            .background(Color.theme.greenMain)
//            .overlay(
//                RoundedRectangle(cornerRadius: 6)
//                    .stroke(.black, lineWidth: 1)
//            )
//        })
//        .buttonStyle(.plain)
//        .popover(isPresented: $isClicked, arrowEdge: .bottom) {
//            
//            VStack(spacing: 0){
//                SecondaryDropdownEnumButton(text: "") {
//                    taskStatus = nil
//                }
//                ForEach(dropOptions, id: \.self) { dropOption in
//                    SecondaryDropdownEnumButton(text: "\(dropOption.displayName)") {
//                        taskStatus = dropOption
//                        isClicked.toggle()
//                    }
//                }
//            }
//        }
//    }
//}
