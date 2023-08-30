//
//  NotificationBarView.swift
//  NeedleApp
//
//  Created by Bof on 02/08/23.
//

import Foundation
import SwiftUI

struct NavigationBarView: View {
    @EnvironmentObject var notificationViewModel: NotificationBarViewModel

    var header: some View {
        HStack {
            Image("simbolo")
            Spacer()
            Text("\(notificationViewModel.notifications.count) notificações")
                .font(.custom(SpaceGrotesk.regular.rawValue, size: 16))
            Spacer()
            Button {
                NotificationDataService.shared.deleteUserNotifications(userId: AuthenticationManager.shared.user!.id)
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
                ForEach(notificationViewModel.notifications){ notification in
                    NotificationCardView(notificationInfo: notification, userName: AuthenticationManager.shared.user!.name)
                    .contextMenu {
                        Button(action: {
                            // TODO: delete item in items array
                        }){
                            Text("Apagar")
                        }
                    }
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
        .onAppear {
            NotificationDataService.shared.getUserNotifications(userId: AuthenticationManager.shared.user!.id)
        }
        .cornerRadius(10)
    }
}
