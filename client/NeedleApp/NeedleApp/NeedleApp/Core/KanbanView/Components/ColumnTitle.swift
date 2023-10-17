//
//  ColumnTitle.swift
//  NeedleApp
//
//  Created by Jpsmor on 04/10/23.
//

import SwiftUI

extension KanbanView {
    @ViewBuilder
    func ColumnTitle(status: TaskStatus, color: Color) -> some View {
        
        var rowName : String {
            var name = ""
            switch status {
            case .TODO:
                name = NSLocalizedString("A fazer", comment: "")
            case .IN_PROGRESS:
                name = NSLocalizedString("Fazendo", comment: "")
            case .PENDING:
                name = NSLocalizedString("Em revisão", comment: "")
            default:
                name = NSLocalizedString("Feito", comment: "")
            }
            return name
        }
        
        VStack(spacing: 5) {
            HStack{
                Spacer()
                    .frame(width: 10)
                Circle()
                    .frame(width: 12)
                    .foregroundColor(color)
                Spacer()
                    .frame(width: 8)
                Text(rowName)
                    .font(
                        Font.custom("SF Pro", size: 18)
                            .weight(.medium)
                    )
                    .foregroundColor(.black)
                Spacer()
                if (status == .TODO) || (status == .IN_PROGRESS) {
                    addTaskButton(status: status)
                }
                Spacer()
                    .frame(width: 10)
                
            }
            .frame(minWidth: 135)
            .frame(height: 32)
            .cornerRadius(5)
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.theme.grayLine)
                .frame(height: 2)
                .frame(maxWidth: .infinity)
            Spacer()
                .frame(height: 5)
        }
        
    }
}
