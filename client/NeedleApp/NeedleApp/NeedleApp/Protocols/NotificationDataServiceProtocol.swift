//
//  NotificationDataServiceProtocol.swift
//  NeedleApp
//
//  Created by matheusvb on 18/08/23.
//

import Foundation

protocol NotificationDataServiceProtocol: ObservableObject {
    var token: String? { get set }
    
    var usersNotifications: [NotificationModel] { get set }
    var usersNotificationsPublisher: Published<[NotificationModel]>.Publisher { get }
    var workspaceNotificationsPublisher: Published<[NotificationModel]>.Publisher { get }
    
    var currError: NetworkingManager.NetworkingError? { get set }
    
    var errorCount: Int { get set }
    var errorCountPublisher: Published<Int>.Publisher { get }
    
    func updateDeviceToken(userId: String)
    func getUserNotifications(userId: String)
    func getWorkspaceNotifications(workspaceId: String)
    func deleteUserNotifications(userId: String)
}
