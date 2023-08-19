//
//  RootViewModel.swift
//  NeedleApp
//
//  Created by matheusvb on 18/08/23.
//

import Foundation
import SwiftUI
import Combine

class RootViewModel<A: AuthenticationManagerProtocol & ObservableObject, N: NotificationDataServiceProtocol & ObservableObject>: ObservableObject {
    @ObservedObject var authManager: A
    @ObservedObject var notificationDS: N
    @Published var notificationIsPresented : Bool = false
    @Published var userLogoutIsPresented : Bool = false
    @Published var showErrorSheet: Bool = false
    
    @Published var notifications: [NotificationModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(manager: A, notificationDS: N) {
        self.authManager = manager
        self.notificationDS = notificationDS
        self.addSubscibers()
    }
    
    func presentNotifications() {
        self.fetchNotifications()
        self.notificationIsPresented.toggle()
    }
    
    func fetchNotifications() {
        notificationDS.getUserNotifications(userId: authManager.user!.id)
    }
    
    func logout() {
        self.authManager.user = nil
    }
    
    func addSubscibers() {
        notificationDS.objectWillChange
            .sink(receiveValue: { [weak self] _ in
                self?.notifications = self?.notificationDS.usersNotifications ?? []
            })
            .store(in: &cancellables)
    }
}
