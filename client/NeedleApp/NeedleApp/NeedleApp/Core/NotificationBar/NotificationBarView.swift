//
//  NotificationBarView.swift
//  NeedleApp
//
//  Created by Bof on 02/08/23.
//

import Foundation
import SwiftUI

class NotificationList: ObservableObject {
    @Published var list: [AppNotification] = [
        AppNotification(username: "Fulano de Tal", type: .accepted, task: "Criar backlog", projectName: "Marketing", timeAgo: "23 minutos"),
        AppNotification(username: "Fulano de Tal", type: .accepted, task: "Rever personas", projectName: "Design", timeAgo: "2 dias")
    ]
}

struct NotificationBarView: View {
    @StateObject var mock = NotificationList()
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var header: some View {
        HStack(spacing: 36) {
            Text("O")
            Text("\(mock.list.count) notificações")
            Text("􀝖")
        }
    }
    
    var notificationStack: some View {
        VStack(alignment: .leading, spacing: 24) {
            ForEach(mock.list.indices, id: \.self) { index in
                NotificationCardView(notificationInfo: AppNotification(username: mock.list[index].username, type: mock.list[index].type, task: mock.list[index].task, projectName: mock.list[index].projectName, timeAgo: mock.list[index].timeAgo))
            }
        }
    }

    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .frame(width: 290, height: 717)
                .shadow(radius: 10, x: 0, y: 4)
            VStack(spacing: 24) {
                header
                .font(.headline)
                .padding(.top, 20)
                .background(.white)
                
                ScrollView {
                    notificationStack
                }
            }
            .foregroundColor(.black)
            .frame(width: 244)
        }
        .cornerRadius(10)
    }
}
