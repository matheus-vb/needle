//
//  NotificationModel.swift
//  NeedleApp
//
//  Created by matheusvb on 10/08/23.
//

import Foundation

struct NotificationModel: Codable, Identifiable {
    let id: String
    let payload: String
    let userId: String
    let workspaceId: String
    let workspace: NotificationWorkspace
    let created_at: String
}

struct NotificationWorkspace: Codable {
    let id: String
    let accessCode: String
    let name: String
}
