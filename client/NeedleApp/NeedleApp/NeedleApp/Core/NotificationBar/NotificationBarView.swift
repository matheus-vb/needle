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

struct NavigationBarView: View {
//    @StateObject var mock = NotificationList()
    @StateObject var mock : NotificationList
    
    var header: some View {
        HStack {
            Image("simbolo")
            Spacer()
            Text("\(mock.list.count) notificações")
                .font(.custom(SpaceGrotesk.regular.rawValue, size: 16))
            Spacer()
            Button {
                self.mock.list.removeAll()
            } label: {
                Text("Limpar")
                    .font(.custom(SpaceGrotesk.regular.rawValue, size: 12))
                    .foregroundColor(Color.theme.blueKanban)
            }.buttonStyle(PlainButtonStyle())
//            Spacer()
//            Text("􀝖")
        }
    }
    
    var notificationStack: some View {
        VStack(alignment: .leading, spacing: 24) {
            List{
                ForEach(mock.list.indices, id: \.self){ index in
                    NotificationCardView(notificationInfo: AppNotification(
                        username: mock.list[index].username,
                        type: mock.list[index].type,
                        task: mock.list[index].task,
                        projectName: mock.list[index].projectName,
                        timeAgo: mock.list[index].timeAgo))
                    .contextMenu {
                        Button(action: {
                            mock.list.remove(at: index)
                            // delete item in items array
                        }){
                            Text("Delete")
                        }
                    }
                }
                .onDelete { indexSet in
                    mock.list.remove(atOffsets: indexSet)
                }
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .frame(width: 290, height: 500)
                .shadow(radius: 10, x: 0, y: 4)
            VStack(spacing: 24) {
                header
                    .font(.headline)
                    .padding(.top, 20)
                    .background(.white)
                notificationStack
                    .scrollContentBackground(.hidden)
            }
            .foregroundColor(.black)
            .frame(width: 244)
        }
        .cornerRadius(10)
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView(mock: NotificationList())
    }
}
