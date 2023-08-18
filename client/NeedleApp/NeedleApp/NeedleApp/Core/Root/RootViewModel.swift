//
//  RootViewModel.swift
//  NeedleApp
//
//  Created by matheusvb on 18/08/23.
//

import Foundation
import SwiftUI

class RootViewModel: ObservableObject {
    @ObservedObject var authManager = AuthenticationManager.shared
    @Published var notificationIsPresented : Bool = false
    @Published var userLogoutIsPresented : Bool = false
    @Published var showErrorSheet: Bool = false
    @ObservedObject var notificationViewModel = NotificationBarViewModel()
    
    func presentNotifications() {
        NotificationDataService.shared.getUserNotifications(userId: AuthenticationManager.shared.user!.id)
        self.notificationIsPresented.toggle()
    }
    
    func logout() {
        self.authManager.user = nil
    }
}
