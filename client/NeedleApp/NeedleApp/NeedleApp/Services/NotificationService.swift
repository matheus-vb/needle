//
//  NotificationService.swift
//  NeedleApp
//
//  Created by matheusvb on 28/07/23.
//

import Foundation
import Combine

class NotificationService: ObservableObject {
    private init(){}
    
    static let shared = NotificationService()
    
    var token: String?
    
    var updateDeviceTokenSubscription: AnyCancellable?
    
    @Published var currError: NetworkingManager.NetworkingError?
    @Published var errorCount: Int = 0
    
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
}
