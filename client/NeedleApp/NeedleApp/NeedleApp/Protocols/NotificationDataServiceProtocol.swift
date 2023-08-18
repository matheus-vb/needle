//
//  NotificationDataServiceProtocol.swift
//  NeedleApp
//
//  Created by matheusvb on 18/08/23.
//

import Foundation

protocol NotificationDataServiceProtocol: ObservableObject {
    func updateDeviceToken(userId: String)
    func getUserNotifications(userId: String)
    func deleteUserNotifications(userId: String)
    
}
