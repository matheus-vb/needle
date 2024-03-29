//
//  NotificationBarView.swift
//  NeedleApp
//
//  Created by Bof on 02/08/23.
//

import Foundation
import SwiftUI

struct NavigationBarView: View {
    @ObservedObject var notificationViewModel: NotificationBarViewModel<NotificationDataService, AuthenticationManager>
    
    init() {
        self.notificationViewModel = NotificationBarViewModel(notificationDS: NotificationDataService.shared, authManager: AuthenticationManager.shared)
    }
    var header: some View {
        HStack {
            Image("simbolo").resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            Spacer()
            Text("\(notificationViewModel.notifications.count) \(NSLocalizedString("notificações", comment: ""))")
                .font(.custom(SpaceGrotesk.regular.rawValue, size: 16))
            Spacer()
            Button {
                notificationViewModel.deleteUserNotification()
            } label: {
                Text(NSLocalizedString("Limpar", comment: ""))
                    .font(.custom(SpaceGrotesk.regular.rawValue, size: 12))
                    .foregroundColor(Color.theme.blueKanban)
            }.buttonStyle(PlainButtonStyle())
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
                            Text(NSLocalizedString("Apagar", comment: ""))
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
            notificationViewModel.getUserNotifications()
        }
        .cornerRadius(10)
    }
}
