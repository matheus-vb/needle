//
//  NotificationBarViewModel.swift
//  NeedleApp
//
//  Created by matheusvb on 10/08/23.
//

import Foundation
import Combine

class NotificationBarViewModel: ObservableObject {
    @Published var notifications: [NotificationModel] = []
    
    private var notificationDS = NotificationDataService.shared
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscibers()
    }
    
    func addSubscibers() {
        notificationDS.$usersNotifications
            .sink(receiveValue: { [weak self] returnedNotifications in
                self?.notifications = returnedNotifications
            })
            .store(in: &cancellables)
    }
}
