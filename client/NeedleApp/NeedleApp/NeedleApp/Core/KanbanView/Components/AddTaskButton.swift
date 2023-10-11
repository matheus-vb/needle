//
//  AddTaskButton.swift
//  NeedleApp
//
//  Created by Jpsmor on 23/08/23.
//

import SwiftUI
import Firebase

extension KanbanView {
    
    @ViewBuilder
    func addTaskButton(status : TaskStatus) -> some View {
        Button {
            Analytics.logEvent(K.tapAddTask.rawValue, parameters: nil)
            kanbanViewModel.showPopUp.toggle()
            kanbanViewModel.selectedColumn = status
        } label: {
            HStack(alignment: .center, spacing: 8) {
                Text(NSLocalizedString("Nova Task", comment: ""))
                    .font(
                        Font.custom("SF Pro", size: 12)
                            .weight(.medium)
                    )
                    .foregroundColor(Color.theme.grayText)
                Image(systemName: "plus")
                    .font(
                        Font.custom("SF Pro", size: 16)
                            .weight(.medium)
                    )
                    .foregroundColor(Color.theme.grayText)
            }
            .frame(width: 88, height: 28)
            .modifier(Clickable())
        }
        .buttonStyle(PlainButtonStyle())
    }
}
