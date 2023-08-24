//
//  AddTaskButton.swift
//  NeedleApp
//
//  Created by Jpsmor on 23/08/23.
//

import SwiftUI

extension KanbanView {
    
    @ViewBuilder
    func addTaskButton(status : TaskStatus) -> some View {
        Button {
            if status == .DONE && kanbanViewModel.role != Role.PRODUCT_MANAGER {
                return
            }
            
            kanbanViewModel.showPopUp.toggle()
            kanbanViewModel.selectedColumn = status
        } label: {
            HStack(alignment: .center, spacing: 8) {
                Image(systemName: "plus")
                    .font(
                        Font.custom("SF Pro", size: 16)
                            .weight(.medium)
                    )
                    .foregroundColor(.black)
                Spacer()
                    .frame(width: 8)
                Text("Adicionar Task")
                    .font(
                        Font.custom("SF Pro", size: 12)
                            .weight(.semibold)
                    )
                    .foregroundColor(.black)
            }
            .padding(5)
            .frame(minWidth: 128, maxWidth: 1000)
            .frame(height: 48)
            .modifier(AddTaskButtonBackground())
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .inset(by: 0.5)
                    .stroke(.black, style: StrokeStyle(lineWidth: 1, dash: [6, 6]))
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
}