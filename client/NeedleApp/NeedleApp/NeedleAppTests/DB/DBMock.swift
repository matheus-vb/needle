//
//  DBMock.swift
//  NeedleAppTests
//
//  Created by matheusvb on 30/08/23.
//

import Foundation

class DBMock {
    var users: [User] = []

    var workspaces: [String: [Workspace]] = [:]
    var usersInWorkspace: [String: [User]] = [:]
    var tasksInWorkspace: [String: [TaskModel]] = [:]
    var notifications: [String: [NotificationModel]] = [:]
    var roles: [String: Role] = [:]
    var deviceToken: [String: String] = [:]
}
