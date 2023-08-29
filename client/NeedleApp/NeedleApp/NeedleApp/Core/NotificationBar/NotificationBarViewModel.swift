//
//  NotificationBarViewModel.swift
//  NeedleApp
//
//  Created by matheusvb on 10/08/23.
//

import Foundation
import Combine

class NotificationBarViewModel<N: NotificationDataServiceProtocol & ObservableObject>: ObservableObject {
    @Published var notifications: [NotificationModel] = []
    private var notificationDS: N
    private var cancellables = Set<AnyCancellable>()
    
    init(notificationDS: N) {
        self.notificationDS = notificationDS
        addSubscibers()
    }
    
    func addSubscibers() {
        notificationDS.usersNotificationsPublisher
            .sink(receiveValue: { [weak self] returnedNotifications in
                self?.notifications = returnedNotifications
            })
            .store(in: &cancellables)
    }
}
