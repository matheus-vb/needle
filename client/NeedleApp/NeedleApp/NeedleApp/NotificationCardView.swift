//
//  NotificationCardView.swift
//  NeedleApp
//
//  Created by Bof on 02/08/23.
//

import Foundation
import SwiftUI

struct NotificationCardView: View {
    var notificationInfo: AppNotification
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(notificationInfo.username + notificationInfo.type.action + notificationInfo.task)
            HStack {
                Text("Projeto " + notificationInfo.projectName + "  ·  " + notificationInfo.timeAgo).font(.footnote)
                    .opacity(0.5)
            }
        }
    }
}

