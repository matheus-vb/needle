//
//  RootViewModel.swift
//  NeedleApp
//
//  Created by matheusvb on 18/08/23.
//

import Foundation
import SwiftUI

class RootViewModel<A: AuthenticationManagerProtocol & ObservableObject, N: NotificationDataServiceProtocol & ObservableObject>: ObservableObject {
    @ObservedObject var authManager: A
    @ObservedObject var notificationDS: N
    @Published var notificationIsPresented : Bool = false
    @Published var userLogoutIsPresented : Bool = false
    @Published var showErrorSheet: Bool = false
    @ObservedObject var notificationViewModel = NotificationBarViewModel()
    
    init(manager: A, notificationDS: N) {
        self.authManager = manager
        self.notificationDS = notificationDS
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
}
