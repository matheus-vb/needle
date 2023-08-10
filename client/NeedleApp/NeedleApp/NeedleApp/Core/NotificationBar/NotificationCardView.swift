//
//  NotificationCardView.swift
//  NeedleApp
//
//  Created by Bof on 02/08/23.
//

import Foundation
import SwiftUI

struct NotificationCardView: View {
    var notificationInfo: NotificationModel
    
    let userName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(userName + ", " + notificationInfo.payload.firstCharacterLowercased())
            HStack {
                Text("Projeto " + notificationInfo.workspace.name + "  ·  " + notificationInfo.created_at.prefix(10)).font(.footnote)
                    .opacity(0.5)
            }
        }
    }
}

