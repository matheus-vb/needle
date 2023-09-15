//
//  RootViewModel.swift
//  NeedleApp
//
//  Created by matheusvb on 18/08/23.
//

import Foundation
import SwiftUI
import Combine

class RootViewModel<
    A: AuthenticationManagerProtocol & ObservableObject,
    N: NotificationDataServiceProtocol & ObservableObject,
    T: TaskDataServiceProtocol & ObservableObject,
    W: WorkspaceDataServiceProtocol & ObservableObject
>: ObservableObject {
    @ObservedObject var authManager: A
    
    private var notificationDS: N
    private var taskDS: T
    private var workspaceDS: W
    
    @Published var notificationIsPresented : Bool = false
    @Published var userLogoutIsPresented : Bool = false
    @Published var showErrorSheet: Bool = false
    
    @Published var notifications: [NotificationModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(manager: A, notificationDS: N, taskDS: T, workspaceDS: W) {
        self.authManager = manager
        self.notificationDS = notificationDS
        self.taskDS = taskDS
        self.workspaceDS = workspaceDS
        
        self.addSubscibers()
        self.setupErrorBindings()
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
        notificationDS.usersNotificationsPublisher
            .sink(receiveValue: { [weak self] receviedNotifications in
                self?.notifications = receviedNotifications
            })
            .store(in: &cancellables)
    }
    
    func setupErrorBindings() {
        Publishers.CombineLatest3(authManager.errorCountPublisher, taskDS.errorCountPublisher, workspaceDS.errorCountPublisher)
            .sink(receiveValue: { authErroCount, taskErrorCount, workspaceErrorCount in
                if (authErroCount + taskErrorCount + workspaceErrorCount) > 3 {
                    self.showErrorSheet.toggle()
                }
            })
            .store(in: &cancellables)
    }
}
