//
//  NotificationDataServiceMock.swift
//  NeedleAppTests
//
//  Created by matheusvb on 30/08/23.
//

import Foundation
import Combine

class NotificationDataServiceMock: NotificationDataServiceProtocol {
    var currError: NetworkingManager.NetworkingError?
    
    let db: DBMock
    
    init(db: DBMock) {
        self.db = db
    }
    
    var token: String?
    @Published var usersNotifications: [NotificationModel] = []
    var usersNotificationsPublisher: Published<[NotificationModel]>.Publisher { $usersNotifications }
    
    func updateDeviceToken(userId: String) {
        guard let token else { return } //TODO: add error
        
        self.db.deviceToken[userId] = token
    }
    
    func getUserNotifications(userId: String) {
        guard let notifications = self.db.notifications[userId] else { return } //TODO: add error
        
        self.usersNotifications = notifications
    }
    
    func deleteUserNotifications(userId: String) {
        self.db.notifications[userId] = []
    }
}
