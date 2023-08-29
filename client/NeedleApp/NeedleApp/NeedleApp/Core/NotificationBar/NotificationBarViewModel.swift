//
//  NotificationBarViewModel.swift
//  NeedleApp
//
//  Created by matheusvb on 10/08/23.
//

import Foundation
import Combine

class NotificationBarViewModel<N: NotificationDataServiceProtocol & ObservableObject, A: AuthenticationManagerProtocol & ObservableObject>: ObservableObject {
    @Published var notifications: [NotificationModel] = []
    private var notificationDS: N
    private var authManeger: A
    private var cancellables = Set<AnyCancellable>()
    
    init(notificationDS: N, authManager: A) {
        self.notificationDS = notificationDS
        self.authManeger = authManager
        addSubscibers()
    }
    
    func addSubscibers() {
        notificationDS.usersNotificationsPublisher
            .sink(receiveValue: { [weak self] returnedNotifications in
                self?.notifications = returnedNotifications
            })
            .store(in: &cancellables)
    }
    
    func deleteUserNotification(){
        print("deletei")
        print(authManeger.user!.id)
        self.notificationDS.deleteUserNotifications(userId: authManeger.user!.id)
    }
    
    func getUserNotifications(){
        self.notificationDS.getUserNotifications(userId: authManeger.user!.id)
    }
}
