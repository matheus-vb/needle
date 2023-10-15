//
//  NotificationService.swift
//  NeedleApp
//
//  Created by matheusvb on 28/07/23.
//

import Foundation
import Combine

class NotificationDataService: NotificationDataServiceProtocol {
    
    
    private init(){}
    
    static let shared = NotificationDataService()
    
    var token: String?
    
    var updateDeviceTokenSubscription: AnyCancellable?
    var getUserNotificationSubscription: AnyCancellable?
    var getWorkspaceNotificationSubscription: AnyCancellable?
    var deleteUserNotificationSubscription: AnyCancellable?

    @Published var currError: NetworkingManager.NetworkingError?
    
    @Published var errorCount: Int = 0
    var errorCountPublisher: Published<Int>.Publisher { $errorCount }
    
    @Published var usersNotifications: [NotificationModel] = []
    @Published var workspaceNotifications: [NotificationModel] = []
    var usersNotificationsPublisher: Published<[NotificationModel]>.Publisher { $usersNotifications }
    var workspaceNotificationsPublisher: Published<[NotificationModel]>.Publisher { $usersNotifications }
    
    func updateDeviceToken(userId: String) {
        guard let url = URL(string: Bundle.baseURL + "user/device") else { return }
        
        guard let deviceToken = token else { return }
        
        let dto = UpdateDeviceTokenDTO(userId: userId, deviceToken: deviceToken)
        let parameters = convertToDictionary(dto)
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else { return }
        
        updateDeviceTokenSubscription = NetworkingManager.patch(url: url, body: jsonData)
            .sink(receiveCompletion: {
                completion in NetworkingManager.handleCompletion(completion: completion) { error in
                    self.currError = error as? NetworkingManager.NetworkingError
                    self.errorCount += 1
                }
            }, receiveValue: { [weak self] _ in
                self?.updateDeviceTokenSubscription?.cancel()
            })
    }
    
    func getUserNotifications(userId: String) {
        guard let url = URL(string: Bundle.baseURL + "notification/\(userId)") else { return }
        
        getUserNotificationSubscription = NetworkingManager.download(url: url)
            .decode(type: NotificationResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: {
                completion in NetworkingManager.handleCompletion(completion: completion) { error in
                    self.currError = error as? NetworkingManager.NetworkingError
                    self.errorCount += 1
                }
            }, receiveValue: { [weak self] (returnedNotifications) in
                self?.usersNotifications = returnedNotifications.data
                self?.getUserNotificationSubscription?.cancel()
            })
    }
    
    func getWorkspaceNotifications(workspaceId: String) {
        guard let url = URL(string: Bundle.baseURL + "workspace/notification/\(workspaceId)") else { return }
        
        getWorkspaceNotificationSubscription = NetworkingManager.download(url: url)
            .decode(type: NotificationResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: {
                completion in NetworkingManager.handleCompletion(completion: completion) { error in
                    self.currError = error as? NetworkingManager.NetworkingError
                    self.errorCount += 1
                }
            }, receiveValue: { [weak self] (returnedNotifications) in
                self?.workspaceNotifications = returnedNotifications.data
                self?.getWorkspaceNotificationSubscription?.cancel()
            })
    }
    
    func deleteUserNotifications(userId: String) {
        guard let url = URL(string: Bundle.baseURL + "notification/\(userId)") else { return }
        
        deleteUserNotificationSubscription = NetworkingManager.delete(url: url)
            .sink(receiveCompletion: {
                completion in NetworkingManager.handleCompletion(completion: completion) { error in
                    self.currError = error as? NetworkingManager.NetworkingError
                    self.errorCount += 1
                }
            }, receiveValue: { [weak self] _ in
                self?.getUserNotifications(userId: userId)
                self?.deleteUserNotificationSubscription?.cancel()
            })
    }
}
